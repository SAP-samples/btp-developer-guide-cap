---
title: Get the Business Partner API and Extend the Incident Management Application
description: Learn how to get the Business Partner API from SAP S/4HANA Cloud and extend the functionality of the Incident Management application.
parser: v2
auto_validation: true
time: 30
tags: [ tutorial>intermediate, software-product-function>sap-cloud-application-programming-model, programming-tool>node-js, software-product>sap-business-technology-platform]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Svetoslav Pandeliev
author_profile: https://github.com/slavipande
---

## You will learn

- How to get the Business Partner API from SAP S/4HANA Cloud.
- How to extend the functionality of the Incident Management application.

## Prerequisites

- You've set up the Incident Management sample application. See [Introduction to Remote Service Connectivity](remote-service-intro).

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Get the Business Partner API

SAP Business Accelerator Hub is a web application hosted by SAP where you can discover, explore, and test SAP and partner APIs (Application Programming Interfaces) that are required to build extensions or process integrations.

In the [SAP Business Accelerator Hub](https://api.sap.com/), you can find the APIs that you need to complete your extension scenario.

For this scenario, you use the Business Partner API from SAP S/4HANA Cloud.

### Download the Business Partner API

1. In SAP Business Accelerator Hub, go to [Business Partner API (A2X)](https://api.sap.com/api/API_BUSINESS_PARTNER/overview).
2. In **API Resources**, select **API Specification**.
3. From the list of files, download the **OData EDMX** file. The file name when downloaded is **API_BUSINESS_PARTNER.edmx**. You need this file later on.

### Add new business logic to the Incident Management application

1. In SAP Business Application Studio, navigate to the **incident-management** root folder of your project.

2. In the **package.json** file, make sure that the `name` property is set to `incident-management`.

    ```json
    {
      "name": "incident-management",
      "version": "1.0.0",
      "dependencies": {
        ....
    ```

3. Add some additional libraries to the **package.json** file for the communication with external systems. In the terminal, go to the **incident-management** root folder of your project and run the following command:  

    ```bash
    npm add @sap-cloud-sdk/http-client@3.x @sap-cloud-sdk/util@3.x @sap-cloud-sdk/connectivity@3.x @sap-cloud-sdk/resilience@3.x
    ```

4. Import the Business Partner API to your project:

    1. In the project explorer, right-click on the project's root folder and choose **Upload...**
    2. Select the **API_BUSINESS_PARTNER.edmx** file and upload it to your project folder.

        > If you're using VS Code instead of SAP Business Application Studio:
        >
        > 1. Skip the previous steps.
        > 2. Paste the already downloaded **API_BUSINESS_PARTNER.edmx** file in your project root folder.
        > 3. Proceed with the following steps.

    3. In the terminal, run the following command:

        ```bash
        cds import API_BUSINESS_PARTNER.edmx --as cds
        ```

    4. You can find the generated files in the **srv/external** folder.

5. Open **srv/external/API_BUSINESS_PARTNER.cds**. Search for **entity A_BusinessPartner**. Scroll down to the **to_BusinessPartnerAddress** section and replace it with the following excerpt:

    ```CDS
    to_BusinessPartnerAddress : Composition of many A_BusinessPartnerAddress on to_BusinessPartnerAddress.BusinessPartner = BusinessPartner;
    ```

6. Search for **entity A_BusinessPartnerAddress**. Replace the associations for e-mail address and phone number with the following excerpt:

    ```CDS
    to_EmailAddress : Composition of many A_AddressEmailAddress on to_EmailAddress.AddressID = AddressID;

    to_PhoneNumber : Composition of many A_AddressPhoneNumber on to_PhoneNumber.AddressID = AddressID;
    ```

7. In the **srv** folder, create a new file **remote.cds** and paste the following code in it:

    ```CDS
    using { API_BUSINESS_PARTNER as S4 } from './external/API_BUSINESS_PARTNER';

    service RemoteService {
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

9. Add application logic for reading and saving a business partner:

    1. Open the **srv/services.js** file.
    2. Set the `init` method to `async`:
  
        ```js[1]
        async init() {
          this.before("UPDATE", "Incidents", (req) => this.onUpdate(req));
          this.after("READ", "Incidents", (data) => this.changeUrgencyDueToSubject(data));

          return super.init();
        }
        ```

    3. Add a custom handler for READ of customers in the **init()** method:

        ```js[4]
        async init() {
          this.before("UPDATE", "Incidents", (req) => this.onUpdate(req));
          this.after("READ", "Incidents", (data) => this.changeUrgencyDueToSubject(data));
          this.on('READ', 'Customers', (req) => this.onCustomerRead(req));

          return super.init();
        }
        ```

    4. Add the custom handler implementation after the **init()** method:

        ```js[9-44]
        async init() {
          this.before("UPDATE", "Incidents", (req) => this.onUpdate(req));
          this.after("READ", "Incidents", (data) => this.changeUrgencyDueToSubject(data));
          this.on('READ', 'Customers', (req) => this.onCustomerRead(req));

          return super.init();
        }

        async onCustomerRead(req) {
          console.log('>> delegating to S4 service...', req.query);
          let { limit, one } = req.query.SELECT
          if(!limit) limit = { rows: { val: 55 }, offset: { val: 0 } } //default limit to 55 rows

          const { BusinessPartner } = this.remoteService.entities;
          const query = SELECT.from(BusinessPartner, bp => {
            bp('*');
            bp.addresses(address => {
              address('email');
              address.email(emails => {
                emails('email');
              });
            });
          }).limit(limit)

          if(one){
            // support for single entity read
            query.where({ ID: req.data.ID });
          }
          // Expands are required as the runtime does not support path expressions for remote services
          let result = await this.S4bupa.run(query);

          result = result.map((bp) => ({
            ID: bp.ID,
            name: bp.name,
            email: (bp.addresses[0]?.email[0]?.email || ''),
            firstName: bp.firstName,
            lastName: bp.lastName,
          }));

          // Explicitly set $count so the values show up in the value help in the UI
          result.$count = 1000;
          console.log("after result", result);
          return result;
        }
        ```

        > **What happens here?**
        >
        > The highlighted snippet defines the `onCustomerRead` method to handle reading of customer data. 
        >
        > The method:
        > - logs the request query
        > - parses the `$top` and `$skip` query options with default values 
        > - extracts the `BusinessPartner` entity from the remote service 
        > - fetches the business partner data from the remote service (including e-mail addresses) 
        > - maps the result to include only the necessary fields 
        > - sets the `$count` property

    5.  Add a custom handler for CREATE and UPDATE of incidents. Add these code lines to the **init()** method:

        ```js[5-7]
        async init() {
          this.before("UPDATE", "Incidents", (req) => this.onUpdate(req));
          this.after("READ", "Incidents", (data) => this.changeUrgencyDueToSubject(data));
          this.on('READ', 'Customers', (req) => this.onCustomerRead(req));
          this.on(['CREATE','UPDATE'], 'Incidents', (req, next) => this.onCustomerCache(req, next));
          this.S4bupa = await cds.connect.to('API_BUSINESS_PARTNER');
          this.remoteService = await cds.connect.to('RemoteService');

          return super.init();
        }
        ```

    6. Add the custom handler implementation after the **init()** method:

        ```js[12-43]
        async init() {
          this.before("UPDATE", "Incidents", (req) => this.onUpdate(req));
          this.after("READ", "Incidents", (data) => this.changeUrgencyDueToSubject(data));
          this.on('READ', 'Customers', (req) => this.onCustomerRead(req));
          this.on(['CREATE','UPDATE'], 'Incidents', (req, next) => this.onCustomerCache(req, next));
          this.S4bupa = await cds.connect.to('API_BUSINESS_PARTNER');
          this.remoteService = await cds.connect.to('RemoteService');

          return super.init();
        }

        async onCustomerCache(req, next) {
          const { Customers } = this.entities;
          const newCustomerId = req.data.customer_ID;
          const result = await next();
          const { BusinessPartner } = this.remoteService.entities;
          if (newCustomerId && newCustomerId !== "") {
            console.log('>> CREATE or UPDATE customer!');

            // Expands are required as the runtime does not support path expressions for remote services
            const customer = await this.S4bupa.run(SELECT.one(BusinessPartner, bp => {
              bp('*');
                bp.addresses(address => {
                  address('email', 'phoneNumber');
                    address.email(emails => {
                      emails('email')
                    });
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

        async onCustomerRead(req) {
          console.log('>> delegating to S4 service...', req.query);
          const top = parseInt(req._queryOptions?.$top) || 100;
          const skip = parseInt(req._queryOptions?.$skip) || 0;
        
          const { BusinessPartner } = this.remoteService.entities;

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

        > **What happens here?**
        >
        > The highlighted snippet defines the `onCustomerCache` method to handle caching of customer data during CREATE or UPDATE events.
        >
        > The method: 
        > - extracts the `Customers` entity and the new customer ID from the request data
        > - calls the next middleware or handler in the chain 
        > - extracts the `BusinessPartner` entity from the remote service 
        > - checks if the new customer ID is valid and if the event is either CREATE or UPDATE 
        > - fetches the customer data from the remote service (including e-mail and phone number)
        > - if the customer data is found, updates the local `Customers` entity while also removing unnecessary fields

10. To run the tests, navigate to the **tests/test.js** file and replace line no.3 with the following highlighted line:

    ```js[3]
    const cds = require('@sap/cds/lib')
    const { default: axios } = require('axios') 
    const { GET, POST, DELETE, PATCH, expect } = cds.test(__dirname + '../../', '--with-mocks');

    axios.defaults.auth = { username: 'incident.support@tester.sap.com', password: 'initial' }

    jest.setTimeout(11111)
    ...
    ```

11. Run the tests:

    ```bash
    npm run test
    ```

 
 You've integrated the Business Partner API into your project and business logic to read the data from the back end system. New or changed customer data is stored in your application database.
