# Extend the Incident Management Application

## Prerequisites

* You have downloaded the [Business Partner API](../prepare/explore-apis-and-events/README.md)

  
## Content

1. Clone the incident management application from Github. 
   
   ```bash
   git clone https://github.com/cap-js/incidents-app.git
   ```

2.  Change the name in package.json to `incidents-mgmt`
    
    ```js
    {
      "name": "incidents-mgmt",
      "version": "1.0.0",
      "dependencies": {
        ....
    ```
3. Now we need to add some additional libraries to the package.json for the communication with external systems. In the terminal go to the incidents-mgmt folder and run the following command:  
   
   ```bash
   npm add @sap-cloud-sdk/http-client@3.x @sap-cloud-sdk/util@3.x @sap-cloud-sdk/connectivity@3.x @sap-cloud-sdk/resilience@3.x
   ```

4. Navigate to db/schema.cds and change the customer entity as below. The cuid flag is removed and an ID field is added as key, this field is later filled with the Business Partner ID from the SAP S/4HANA system.

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

5. Navigate to db/data/sap.capire.incidents-Customers.csv and change the data as below. The cuid flag is removed and an ID field is added as key in the previous step. The same to be replicated in the data

  ```csv
  ID,firstName,lastName,email,phone
  1004155,Daniel,Watts,daniel.watts@demo.com,+44-555-123
  1004161,Stormy,Weathers,stormy.weathers@demo.com,
  1004100,Sunny,Sunshine,sunny.sunshine@demo.com,+01-555-789
  ```

6. The same to be brought in to db/data/sap.capire.incidents-incidents.csv

  ```csv
  ID,customer_ID,title,urgency_code,status_code
  3b23bb4b-4ac7-4a24-ac02-aa10cabd842c,1004155,Inverter not functional,H,C
  3a4ede72-244a-4f5f-8efa-b17e032d01ee,1004161,No current on a sunny day,H,N
  3ccf474c-3881-44b7-99fb-59a2a4668418,1004161,Strange noise when switching off Inverter,M,N
  3583f982-d7df-4aad-ab26-301d4a157cd7,1004100,Solar panel broken,H,I
  ```

7. Import the Business Partner API to your project.
   * In the project explorer do a right-click. Select **Upload...**

     ![upload API](./images/upload-api.png)

   * Select the API_BUSINESS_PARTNER.edmx file and upload it to your project folder.
   * In the terminal execute the following command
  
      ```bash
      cds import API_BUSINESS_PARTNER.edmx --as cds
      ```
   * You find the generated files in the **srv/external** folder 

8. Now we change the conditions for the relationships between some entities. Open **srv/external/API_BUSINESS_PARTNER.cds**. Search for **entity API_BUSINESS_PARTNER.A_BusinessPartner**. Scroll down to the to_BusinessPartnerAddress section and replace it with the following:

    ```js
    to_BusinessPartnerAddress : Composition of many API_BUSINESS_PARTNER.A_BusinessPartnerAddress on to_BusinessPartnerAddress.BusinessPartner = BusinessPartner;
    ```

9. Search for **entity API_BUSINESS_PARTNER.A_BusinessPartnerAddress**. Replace the associations for email address and phone number.

    ```js
    to_EmailAddress : Composition of many API_BUSINESS_PARTNER.A_AddressEmailAddress on to_EmailAddress.AddressID = AddressID;

    to_PhoneNumber : Composition of many API_BUSINESS_PARTNER.A_AddressPhoneNumber on to_PhoneNumber.AddressID = AddressID;
    ```

10. In the next steps we add some of the Business Partner entities to the project service model. Open the  srv/processors-service.cds file. On the top add the import for the Business Partner API

    ```js
    using { API_BUSINESS_PARTNER as S4 } from './external/API_BUSINESS_PARTNER';
    ```

11. Add the below code snippet to the ProcessorService: 

    ```js
    service ProcessorService {

      entity Incidents as projection on my.Incidents;

      @readonly
      entity Customers as projection on my.Customers;
    }
    
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

10. Now we add some buisness logic for reading and saving a business partner. 
   * Open the srv/processor-service.js file. 
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

        var result = await this.S4bupa.run(SELECT.from(BusinessPartner, bp => {
          bp('*'),
            bp.addresses(address => {
              address('*'),
                address.email(emails => {
                  emails('*');
                });
            })
        }).limit(top, skip));

        result = result.map((bp) => ({
          ID: bp.ID,
          name: bp.name,
          email: bp.addresses[0]?.email[0]?.email
        }));
        result.$count = 1000;
        console.log("after result", result);
        return result;
      }
      
    ```

*  Add a custom handler for CREATE, UPDATE, DELETE of incidents. Add the below code snippet to the init method

    ```js
    this.on(['CREATE','UPDATE'], 'Incidents', (req, next) => this.onCustomerCache(req, next));
    this.S4bupa = await cds.connect.to('API_BUSINESS_PARTNER');
    ```
* Add the custom handler after init method
  ```js
  async onCustomerCache(req, next) {
      const { Customers } = this.entities;
      const newCustomerId = req.data.customer_ID
      const result = await next();
      const { BusinessPartner } = this.entities;
      if (newCustomerId && (newCustomerId !== "") && ((req.event == "CREATE") || (req.event == "UPDATE"))) {
        console.log('>> CREATE or UPDATE customer!')
        var customer = await this.S4bupa.run(SELECT.one(BusinessPartner, bp => {
          bp('*'),
            bp.addresses(address => {
              address('*'),
                address.email(emails => {
                  emails('*')
                }),
                address.phoneNumber(phoneNumber => {
                  phoneNumber('*')
                })
            })
        }).where({ ID: newCustomerId }));
        customer.email = customer.addresses[0]?.email[0]?.email
        customer.phone = customer.addresses[0]?.phoneNumber[0]?.phone
      };
      if (customer) {
        delete customer.addresses;
        delete customer.name;
        await UPSERT.into(Customers).entries(customer)
      }

      return result;
    }

    ```

11. To run tests, navigate to `tests/test.js` and  Replace line no.3 with the below code snippet

    ```js
    const { GET, POST, DELETE, PATCH, expect } = cds.test(__dirname + '../../', '--with-mocks');
    ```

    Now you can run tests by

    ```sh
    npm run test
    ```

 ## Summary
 You have integrated the Business Partner API into your project and business logic to to read the data from the backend system. New or changed customer data would be stored at your application database.


   
