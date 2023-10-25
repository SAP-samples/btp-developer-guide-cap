# Extend the Incident Management Application

## Prerequisites

* You have ensured that the [prerequisites are fullfilled and all the required systems are in place](../mission-prerequisites/README.md)
* You have downloaded the [Business Partner API](../prepare/explore-apis-and-events/README.md)

## Content

1. Navigate to the project's root folder of the Incident Management application. 
   
2.  In the *package.json*, change the name to `incident-management`.
    
    ```js
    {
      "name": "incident-management",
      "version": "1.0.0",
      "dependencies": {
        ....
    ```
3. Add some additional libraries to the *package.json* for the communication with external systems. In the terminal, go to the project's root folder of the Incident Management application and run the following command:  
   
   ```bash
   npm add @sap-cloud-sdk/http-client@3.x @sap-cloud-sdk/util@3.x @sap-cloud-sdk/connectivity@3.x @sap-cloud-sdk/resilience@3.x
   ```

4. Navigate to *db/schema.cds* and change the customer entity as below. The cuid flag is removed and an ID field is added as key, this field is later filled with the Business Partner ID from the SAP S/4HANA system.

   ```js
    entity Customers : managed {
      key ID        : String;
      firstName     : String;
      lastName      : String;
      email         : EMailAddress;
      phone         : PhoneNumber;
      incidents     : Association to many Incidents on incidents.customer = $self;
    }
   ```

5. Navigate to *db/data/sap.capire.incidents-Customers.csv* and change the data as below. The cuid flag is removed and an ID field is added as key in the previous step. The same has to be replicated in the data.

  ```csv
  ID,firstName,lastName,email,phone
  1004155,Daniel,Watts,daniel.watts@demo.com,+44-555-123
  1004161,Stormy,Weathers,stormy.weathers@demo.com,
  1004100,Sunny,Sunshine,sunny.sunshine@demo.com,+01-555-789
  ```

6. Change the same data in *db/data/sap.capire.incidents-incidents.csv*.

  ```csv
  ID,customer_ID,title,urgency_code,status_code
  3b23bb4b-4ac7-4a24-ac02-aa10cabd842c,1004155,Inverter not functional,H,C
  3a4ede72-244a-4f5f-8efa-b17e032d01ee,1004161,No current on a sunny day,H,N
  3ccf474c-3881-44b7-99fb-59a2a4668418,1004161,Strange noise when switching off Inverter,M,N
  3583f982-d7df-4aad-ab26-301d4a157cd7,1004100,Solar panel broken,H,I
  ```

7. Import the Business Partner API to your project.
   * In the project explorer, right-click and select **Upload...**

     ![upload API](./images/upload-api.png)

   * Select the *API_BUSINESS_PARTNER.edmx* file and upload it to your project folder.
   * In the terminal, run the following command
  
      ```bash
      cds import API_BUSINESS_PARTNER.edmx --as cds
      ```
   * You can find the generated files in the **srv/external** folder.

8. Change the conditions for the relationships between some entities. Open **srv/external/API_BUSINESS_PARTNER.cds**. Search for **entity API_BUSINESS_PARTNER.A_BusinessPartner**. Scroll down to the **to_BusinessPartnerAddress** section and replace it with the following:

    ```js
    to_BusinessPartnerAddress : Composition of many API_BUSINESS_PARTNER.A_BusinessPartnerAddress on to_BusinessPartnerAddress.BusinessPartner = BusinessPartner;
    ```

9. Search for **entity API_BUSINESS_PARTNER.A_BusinessPartnerAddress**. Replace the associations for email address and phone number.

    ```js
    to_EmailAddress : Composition of many API_BUSINESS_PARTNER.A_AddressEmailAddress on to_EmailAddress.AddressID = AddressID;

    to_PhoneNumber : Composition of many API_BUSINESS_PARTNER.A_AddressPhoneNumber on to_PhoneNumber.AddressID = AddressID;
    ```

10. Create a new file *extend.cds* in the *srv* folder.

11. Copy the snippet to the newly created *extend.cds* file

    ```js
    using { sap.capire.incidents as my } from '../db/schema';
    using { API_BUSINESS_PARTNER as S4 } from './external/API_BUSINESS_PARTNER';
    using from './processor-service';

    extend service ProcessorService {
      entity BusinessPartner as projection on S4.A_BusinessPartner {
        key BusinessPartner as ID,
        FirstName as firstName,
        LastName as lastName,
        BusinessPartnerName as name,
        to_BusinessPartnerAddress as addresses
      }
      entity BusinessPartnerAddress as projection on S4.A_BusinessPartnerAddress {
                BusinessPartner as ID,
                AddressID as addressId,
                to_EmailAddress as email,
                to_PhoneNumber as phoneNumber
      }
      entity EmailAddress as projection on S4.A_AddressEmailAddress {
          key AddressID as addressId,
          EmailAddress as email
      }

      entity PhoneNumber as projection on S4.A_AddressPhoneNumber {
          key AddressID as addressId,
          PhoneNumber as phone
      }
    }
    ```

10. Now add some buisness logic for reading and saving a business partner. 
   * Open the *srv/processor-service.js* file. 
   * Set the `init` method to `async` 
  
      ```js
      async init() {
        this.before("UPDATE", "Incidents", (req) => this.onUpdate(req));
        this.after("READ", "Incidents", (data) => this.changeUrgencyDueToSubject(data));

        return super.init();
      }
      ```
   * Add a custom handler for READ of customers in the init() method 
      
      ```js
      this.on('READ', 'Customers', (req) => this.onCustomerRead(req));
      ```

  * Add the custom handler implementation after the init method
      ```js
        async onCustomerRead(req) {
          console.log('>> delegating to S4 service...', req.query);
          const top = parseInt(req._queryOptions?.$top) || 100;
          const skip = parseInt(req._queryOptions?.$skip) || 0;
        
          const { BusinessPartner } = this.entities;

          // Expands are required as the runtime does not support path expressions for remote services
          let result = await this.S4bupa.run(SELECT.from(BusinessPartner, bp => {
            bp('*'),
              bp.addresses(address => {
                address('email'),
                  address.email(emails => {
                    emails('email');
                  });
              })
          }).limit(top, skip));
        
          result = result.map((bp) => ({
            ID: bp.ID,
            name: bp.name,
            email: bp.addresses[0]?.email[0]?.email
          }));

          // Explicitly set $count so the values show up in the value help in the UI
          result.$count = 1000;
          console.log("after result", result);
          return result;
        }   
    ```

*  Add a custom handler for CREATE, UPDATE, DELETE of incidents. Add this code snippet to the *init* method

    ```js
    this.on(['CREATE','UPDATE'], 'Incidents', (req, next) => this.onCustomerCache(req, next));
    this.S4bupa = await cds.connect.to('API_BUSINESS_PARTNER');
    ```
* Add the custom handler after the *init* method

  ```js
    async onCustomerCache(req, next) {
      const { Customers } = this.entities;
      const newCustomerId = req.data.customer_ID;
      const result = await next();
      const { BusinessPartner } = this.entities;
      if (newCustomerId && (newCustomerId !== "") && ((req.event == "CREATE") || (req.event == "UPDATE"))) {
        console.log('>> CREATE or UPDATE customer!');

        // Expands are required as the runtime does not support path expressions for remote services
        const customer = await this.S4bupa.run(SELECT.one(BusinessPartner, bp => {
          bp('*'),
            bp.addresses(address => {
              address('email', 'phoneNumber'),
                address.email(emails => {
                  emails('email')
                }),
                address.phoneNumber(phoneNumber => {
                  phoneNumber('phone')
                })
            })
        }).where({ ID: newCustomerId }));
                                                                                      
        if(customer) {
          customer.email = customer.addresses[0]?.email[0]?.email;
          customer.phone = customer.addresses[0]?.phoneNumber[0]?.phone;
          delete customer.addresses;
          delete customer.name;
          await UPSERT.into(Customers).entries(customer);
        }
      }
      return result;
      }
    ```

11. To run tests, navigate to `tests/test.js` and replace line no.3 with the code snippet below

    ```js
    const { GET, POST, DELETE, PATCH, expect } = cds.test(__dirname + '../../', '--with-mocks');
    ```

    Now you can run tests by

    ```sh
    npm run test
    ```

 ## Result
 You have integrated the Business Partner API into your project and business logic to read the data from the backend system. New or changed customer data would be stored in your application database.


   
