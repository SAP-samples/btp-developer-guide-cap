---
title: Test the Extended Incident Management Application with the Business Partner API
description: Learn how to test the extended Incident Management application with a local mock server.
parser: v2
auto_validation: true
time: 30
tags: [ tutorial>intermediate, software-product-function>sap-cloud-application-programming-model, programming-tool>node-js, software-product>sap-business-technology-platform]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Svetoslav Pandeliev
author_profile: https://github.com/slavipande
---

## You will learn

- How to increase your development speed by running and testing your implementation in a local environment.
- How to set up and use a local mock server for running your development tests for the extended Incident Management application.

## Prerequisites

- You've got the Business Partner API from SAP S/4HANA Cloud and have extended the functionality of the Incident Management application. Follow the steps in the [Get the Business Partner API and Extend the Incident Management Application](remote-service-extend) tutorial.

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Create mock data for the new entities

Since you already have a SQLite in-memory database that was automatically created in the previous step, let's now fill it in with some test data.

1. Navigate to the Incident Management application project and create a new folder **data** in the **srv/external** folder.

2. In the **data** folder, create a new file **API_BUSINESS_PARTNER-A_BusinessPartner.csv** and add the following data to it:

    ```csv
    BusinessPartner;FirstName;LastName;BusinessPartnerName;BusinessPartnerIsBlocked;
    1004155;Daniel;Watts;Daniel Watts;false
    1004161;Stormy;Weathers;Stormy Weathers;false
    1004100;Sunny;Sunshine;Sunny Sunshine;true
    ```

3. In the **data** folder, create a new file **API_BUSINESS_PARTNER-A_BusinessPartnerAddress.csv** and add the following data to it:

    ```csv
    BusinessPartner;AddressID;
    1004155;123
    1004161;345
    1004100;456
    ```

4. In the **data** folder, create a new file **API_BUSINESS_PARTNER-A_AddressEmailAddress.csv** and add the following data to it:

    ```csv
    AddressID;EmailAddress;Person;OrdinalNumber
    123;test@demo.com;Williams;123
    345;testjohn@demo.com;Smith;222
    456;testhencry@demo.com;johnson;333
    ```

5. In the **data** folder, create a new file **API_BUSINESS_PARTNER-A_AddressPhoneNumber.csv** and add the following data to it:

    ```csv
    AddressID;PhoneNumber;Person;OrdinalNumber
    123;+44-555-123;Daniel;123
    345;+01-555-688;Stormy;222
    456;+01-555-789;Sunny;333
    ```

### Run and test the Incident Management application locally

1. Install dependencies.

    ```bash
    npm i
    ```

2. Run the mock server locally.

    ```bash
    cds mock API_BUSINESS_PARTNER
    ```

3. In the terminal, you see the following output:

    ```cds
    [cds] - connect using bindings from: { registry: '~/.cds-services.json' }
    [cds] - connect to db > sqlite { url: ':memory:' }
       > init from db/data/sap.capire.incidents-Urgency.csv 
       > init from db/data/sap.capire.incidents-Status.csv 
       > init from db/data/sap.capire.incidents-Incidents.csv 
       > init from db/data/sap.capire.incidents-Customers.csv 
       > init from db/data/sap.capire.incidents-Conversations.csv 
       > init from srv/external/data/API_BUSINESS_PARTNER-A_BusinessPartnerAddress.csv 
       > init from srv/external/data/API_BUSINESS_PARTNER-A_BusinessPartner.csv 
       > init from srv/external/data/API_BUSINESS_PARTNER-A_AddressPhoneNumber.csv 
       > init from srv/external/data/API_BUSINESS_PARTNER-A_AddressEmailAddress.csv  
    ```

    > If the API_BUSINESS_PARTNER doesn't show up, remove the **.cds-services.json** file that resides in the user root folder, for example, **/home/user/.cds-services.json**.

4. Open a new terminal and run `cds watch`. This command starts the application connected to the running mock server.

5. Open a browser and open the server URL: `http://localhost:4004`.

6. Choose **/launchpage.html** under **Web Applications**.

    <!-- border; size:540px --> ![CAP index page](./cap-index-page.png)

    **/launchpage.html** uses a [local launchpage](!https://pages.github.tools.sap/cap/golden-path/develop/Launchpage/Launchpage), while **/incidents/webapp/index.html** uses the **index.html** from [ui5 app](!https://pages.github.tools.sap/cap/golden-path/develop/btp-app-create-ui-fiori-elements/btp-app-create-ui-fiori-elements).

7. Choose the **Incident Management** tile.

    <!-- border; size:540px --> ![Incident Management tile on the launchpage](./incident-management-tile.png)

7. When you're prompted to authenticate, use the following credentials:

    - Username: `alice`
    - Password: Empty / No Password

    <!-- border; size:540px --> ![Log in](./incident-management-log-in.png)

    > You find the user settings in the **.cdsrc.json** file.

9. Choose **Create** to start creating a new incident.
  
    <!-- border; size:540px --> ![Create a new incident](./create-new-incident.png)

11. Open the value help for the **Customer** field.

    <!-- border; size:540px --> ![Value help for Customer field](./value-help-customer.png)

12. Verify that customer data is fetched from the mock server.

    <!-- border; size:540px --> ![Data in value help](./value-help-data.png)

    To test the scenario, the value help for customers loads data from the mock server while creating a new incident.

By using a local mock server, you can easily test your implementation in a local environment. Find more details at [Local Mocking](https://cap.cloud.sap/docs/guides/using-services#local-mocking) in the CAP documentation.
