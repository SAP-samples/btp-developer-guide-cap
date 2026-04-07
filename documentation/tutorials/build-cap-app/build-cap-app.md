---
title: Build a CAP Application
description: This guide is a step-by-step walkthrough to build a CAP Node.js or Java application. 
parser: v2
auto_validation: true
time: 30
tags: [ tutorial>beginner, programming-tool>sapui5, programming-tool>java, programming-tool>node-js, software-product>sap-business-technology-platform, software-product>sap-fiori, software-product-function>sap-cloud-application-programming-model]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Svetoslav Pandeliev
author_profile: https://github.com/slavipande
---


## You will learn

- How to create a CAP project. 
- How to add a domain model.
- How to create services.
- How to add data to your database.

## Prerequisites

You've configured the SAP Business Application Studio. Follow the steps in the [Set Up SAP Business Application Studio for Development](set-up-bas) tutorial that is part of the [Develop a Full-Stack CAP Application Following SAP BTP Developer’s Guide](https://developers.sap.com/group.cap-application-full-stack.html) tutorial group.


> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Create a CAP project

> You can create a CAP project in either Node.js or Java. You have to choose one way or the other and follow through. The tabs **Node.js** and **Java** provide detailed steps for each alternative way. 

[OPTION BEGIN [Node.js]]

1. In SAP Business Application Studio, go to your **IncidentManagement** dev space.

    > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

2. Choose the burger menu and choose **Terminal** &rarr; **New Terminal**.

    <!-- border; size:540px --> ![Terminal](./bas-terminal.png)

3. Navigate to the **projects** folder from the root directory.

    ```bash
    cd projects
    ```

    > Your main interaction is through the `cds` command. It's used to build, run, and debug your CAP application. You can also use `cds` to enrich your application with additional capabilities such as messaging, multitenancy, or cloud integration. You can learn more about the tool's capabilities in [Command Line Interface (CLI)](https://cap.cloud.sap/docs/tools/cds-cli).

4. Create a new project using [`cds init`](https://cap.cloud.sap/docs/tools/cds-cli#cds-init).

    ```bash
    cds init --add nodejs incident-management
    ```

    > This command creates a folder **incident-management** with your newly created CAP project.


5. Choose the **Explorer** icon and then choose **Open Folder**. Type `/home/user/projects/` in the field and select `incident-management`. Choose **OK** to open the project in SAP Business Application Studio.

    <!-- border; size:540px --> ![Open SAP Business Application Studio folder](./bas-open-folder.png)

    > You can also use the **Cmd+Shift+E** (macOS) or **Ctrl+Shift+E** (Windows/Linux) key combination to quickly navigate to the **Explorer**.
  
6. While you're in the **incident-management** folder, choose the burger menu and then choose **Terminal** &rarr; **New Terminal**.

7. Install dependencies with the following command:

    ```bash
    npm install
    ```

8. Start a CAP server:

    ```bash
    cds watch
    ```

    The CAP server serves all the CAP sources from your project. It also "watches" all the files in your projects and conveniently restarts whenever you save a file. Changes you've made are immediately served without you having to run the command again. In this newly created project the CAP server tells you that there are no models or service definitions yet that it can serve.

    Here is the output that you get:

    ```bash
    cds serve all --with-mocks --in-memory?
    live reload enabled for browsers

    ___________________________

    No models found in db/,srv/,app/,schema,services.
    Waiting for some to arrive...
    ```

[OPTION END]

[OPTION BEGIN [Java]]

1. In SAP Business Application Studio, go to your **IncidentManagement** dev space.

    > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

2. Choose the burger menu and choose **Terminal** &rarr; **New Terminal**.

    <!-- border; size:540px --> ![Terminal](./bas-terminal.png)

3. Navigate to the **projects** folder from the root directory.

    ```bash
    cd projects
    ```

    > Your main interaction is through the `cds` command. It's used to build, run, and debug your CAP application. You can also use `cds` to enrich your application with additional capabilities such as messaging, multitenancy, or cloud integration. You can learn more about the tool's capabilities in [Command Line Interface (CLI)](https://cap.cloud.sap/docs/tools/cds-cli).

4. Create a new project using [`cds init`](https://cap.cloud.sap/docs/tools/cds-cli#cds-init).

    ```bash
    cds init incident-management --add java
    ```

    > This command creates a folder **incident-management** with your newly created CAP Java project.

5. Choose the **Explorer** icon and then choose **Open Folder**. Type `/home/user/projects/` in the field and select `incident-management`. Choose **OK** to open the project in SAP Business Application Studio.

    <!-- border; size:540px --> ![Open SAP Business Application Studio folder](./bas-open-folder.png)

    > You can also use the **Cmd+Shift+E** (macOS) or **Ctrl+Shift+E** (Windows/Linux) key combination to quickly navigate to the **Explorer**.
  
6. While you're in the **incident-management** folder, choose the burger menu and then choose **Terminal** &rarr; **New Terminal**.

7. Navigate to the **srv** folder.

    ```bash
    cd srv
    ```


8. Run the following command to start a CAP Java server:


    ```bash
    mvn cds:watch
    ```

    The CAP server serves all the CAP sources from your project. It also "watches" all the files in your projects and conveniently restarts whenever you save a file. Changes you've made are immediately served without you having to run the command again. In this newly created project the CAP server tells you that there are no models or service definitions yet that it can serve.

    Here is the output that you get:

    ```bash
    [INFO] Scanning for projects...
    [INFO] 
    [INFO] --------------------< customer:incident-management >--------------------
    [INFO] Building incident-management 1.0.0-SNAPSHOT
    [INFO]   from pom.xml
    [INFO] --------------------------------[ jar ]---------------------------------
    [INFO] 
    [INFO] --- cds-maven-plugin:3.4.1:watch (default-cli) @ incident-management ---
    
    [INFO] CdsMojo: building project [/home/user/projects/incident-management], clean [true]
    cds-dk [8.4.1], cds [8.4.1], compiler [5.4.2], home [/home/user/projects/incident-management/node_modules/@sap/cds-dk/node_modules/@sap/cds]

    {
      build: {
        target: '.',
          tasks: [
            { for: 'java', src: 'srv', options: { model: ['db', 'srv'] }}
          ]
      }
    }


    no CDS model found for [java] build task [/home/user/projects/incident-management/srv] - nothing to be done
    ```
    The CAP server also prints a message `BUILD FAILURE` stating that the build has failed. After this message, the CAP server waits for any changes on the filesystem and tries a rebuild. So, let's go on and add a domain model.

[OPTION END]

### Add a domain model

1. In the **db** folder, create a new **schema.cds** file.

2. Paste the following code snippet in the **schema.cds** file.

    ```CDS
    using {
      cuid,
      managed,
      sap.common.CodeList
    } from '@sap/cds/common';
    
    namespace sap.capire.incidents;
    
    /**
    * Incidents created by Customers.
    */
    entity Incidents : cuid, managed {
      customer     : Association to Customers;
      title        : String @title: 'Title';
      urgency      : Association to Urgency default 'M';
      status       : Association to Status default 'N';
      conversation : Composition of many {
                       key ID        : UUID;
                           timestamp : type of managed : createdAt;
                           author    : type of managed : createdBy;
                           message   : String;
                     };
    }
    
    /**
    * Customers entitled to create support Incidents.
    */
    entity Customers : managed {
      key ID           : String;
          firstName    : String;
          lastName     : String;
          name         : String = trim(firstName || ' ' || lastName);
          email        : EMailAddress;
          phone        : PhoneNumber;
          incidents    : Association to many Incidents
                           on incidents.customer = $self;
          creditCardNo : String(16) @assert.format: '^[1-9]\d{15}$';
          addresses    : Composition of many Addresses
                           on addresses.customer = $self;
    }
    
    entity Addresses : cuid, managed {
      customer      : Association to Customers;
      city          : String;
      postCode      : String;
      streetAddress : String;
    }
    
    entity Status : CodeList {
      key code        : String enum {
            new = 'N';
            assigned = 'A';
            in_process = 'I';
            on_hold = 'H';
            resolved = 'R';
            closed = 'C';
          };
          criticality : Integer;
    }
    
    entity Urgency : CodeList {
      key code : String enum {
            high = 'H';
            medium = 'M';
            low = 'L';
          };
    }
    
    type EMailAddress : String;
    type PhoneNumber  : String;
    ```


> **What happens here?**
>
> The provided CDS code snippet defines several entities and their relationships.
> 
> The `Incidents` entity represents incidents created by customers, with fields for customer, title, urgency, status, and a composition of many conversations. Each conversation has an ID, timestamp, author, and message.
>
> The `Customers` entity represents customers who can create support incidents. It includes fields for ID, first name, last name, e-mail, phone, credit card number, and a composition of many addresses. The name field is calculated from the `firstName` and `lastName` fields. Elements can be specified with a calculation expression, in which you can refer to other elements of the same entity. These calculated elements are used for convenience. For more information, see [Calculated Elements](https://cap.cloud.sap/docs/cds/cdl#calculated-elements).
> 
> The `Addresses` entity represents the addresses of customers, with fields for customer, city, postcode, and street address.
> 
> The `Status` and `Urgency` entities represent the status and urgency of incidents, respectively. Both are of type `CodeList` and include a code field with a set of predefined values.
>
> The `EMailAddress` and `PhoneNumber` are defined as types of `String`.
>
> The code also includes the use of `cuid` and `managed` from `@sap/cds/common`, which are common features for defining entities in CDS. The `cuid` feature provides a unique identifier for an entity, while `managed` adds common administrative fields such as `createdAt` and `createdBy`.


[OPTION BEGIN [Node.js]]

As soon as you paste the code in your newly created file, the CAP server that is still running reacts immediately with a new output:

```bash
[cds] - loaded model from 2 file(s):

  db/schema.cds
  <path-to>/node_modules/@sap/cds/common.cds

[cds] - connect using bindings from: { registry: '~/.cds-services.json' }
[cds] - connect to db > sqlite { url: ':memory:' }
/> successfully deployed to in-memory database.  
```

This output means that the CAP server detected the changes in **schema.cds** and automatically created an in-memory SQLite database when restarting the server process. However, the CAP server also prints this message:

```bash
No service definitions found in loaded models.
Waiting for some to arrive...
```

[OPTION END]

[OPTION BEGIN [Java]]

At this stage, the CAP server that is still running detects the changes in **schema.cds** and automatically creates an in-memory SQLite database when restarting the server process. However, there are still no service definitions.

[OPTION END]

### Create services

It's a good practice in CAP to create [single-purposed services](https://cap.cloud.sap/docs/guides/providing-services#single-purposed-services). Therefore, let's define a `ProcessorService` that support engineers use to process incidents created by customers. Let's also define an `AdminService` that administrators use to perform admin activities such as analyzing audit logs.

To create the services' definition:

[OPTION BEGIN [Node.js]]

1. In the **srv** folder, create a new **services.cds** file.

2. Paste the following code snippet in the **services.cds** file:

    ```CDS
    using {sap.capire.incidents as my} from '../db/schema';
    
    /**
     * Service used by support personell, i.e. the incidents' 'processors'.
     */
    service ProcessorService {
        entity Incidents as projection on my.Incidents;
    
        @readonly
        entity Customers as projection on my.Customers;
    }
    
    /**
     * Service used by administrators to manage customers and incidents.
     */
    service AdminService {
        entity Customers as projection on my.Customers;
        entity Incidents as projection on my.Incidents;
    }
    ```
  

This time, the CAP server reacted with additional output:

```bash
[cds] - serving ProcessorService { path: '/odata/v4/processor' }
[cds] - serving AdminService { path: '/odata/v4/admin' }

[cds] - server listening on { url: 'http://localhost:4004' }
[cds] - [ terminate with ^C ]
```

As you can see in the log output, the new file created two generic service providers: `ProcessorService` that serves requests on the `/odata/v4/processor` endpoint and `AdminService` that serves requests on the `/odata/v4/admin` endpoint. If you open the link `http://localhost:4004` from SAP Business Application Studio in your browser, you see the generic `index.html` page:

<!-- border; size:540px --> ![index.html](./index.png)

You have to stop the CAP server with <kbd>Ctrl</kbd> + <kbd>C</kbd> and start it again with the `cds watch` command.

[OPTION END]

[OPTION BEGIN [Java]]

1. In the **srv** folder, create a new **services.cds** file.

2. Paste the following code snippet in the **services.cds** file:

    ```CDS
    using { sap.capire.incidents as my } from '../db/schema';

    /**
     * Service used by support personell, i.e. the incidents' 'processors'.
     */
    service ProcessorService { 
        entity Incidents as projection on my.Incidents;

        @readonly
        entity Customers as projection on my.Customers;
    }

    /**
     * Service used by administrators to manage customers and incidents.
     */
    service AdminService {
        entity Customers as projection on my.Customers;
        entity Incidents as projection on my.Incidents;
        }
    ```
  


    This time, the CAP server reacted with additional output:

    ```bash
    2024-12-06T14:02:29.740Z  INFO 10998 --- [  restartedMain] c.s.c.services.impl.ServiceCatalogImpl   : Registered service AdminService
    2024-12-06T14:02:29.742Z  INFO 10998 --- [  restartedMain] c.s.c.services.impl.ServiceCatalogImpl   : Registered service ProcessorService
    2024-12-06T14:02:29.743Z  INFO 10998 --- [  restartedMain] .s.c.r.CdsRuntimeBeanDefinitionRegistrar : Auto-configuration of DataSource beans is explicitly disabled.
    2024-12-06T14:02:30.161Z  INFO 10998 --- [  restartedMain] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port 8080 (http)
    2024-12-06T14:02:30.175Z  INFO 10998 --- [  restartedMain] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
    2024-12-06T14:02:30.175Z  INFO 10998 --- [  restartedMain] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/10.1.31]
    2024-12-06T14:02:30.199Z  INFO 10998 --- [  restartedMain] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
    2024-12-06T14:02:30.199Z  INFO 10998 --- [  restartedMain] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 944 ms
    2024-12-06T14:02:30.217Z  INFO 10998 --- [  restartedMain] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Starting...
    2024-12-06T14:02:30.339Z  INFO 10998 --- [  restartedMain] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Added connection conn0: url=jdbc:h2:mem:ef5eb10f-0fc9-413e-9358-0c9e2365c3aa user=SA
    2024-12-06T14:02:30.340Z  INFO 10998 --- [  restartedMain] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Start completed.
    2024-12-06T14:02:30.348Z  INFO 10998 --- [  restartedMain] o.s.b.a.h2.H2ConsoleAutoConfiguration    : H2 console available at '/h2-console'. Database available at 'jdbc:h2:mem:ef5eb10f-0fc9-413e-9358-0c9e2365c3aa'
    2024-12-06T14:02:30.388Z  INFO 10998 --- [  restartedMain] c.s.c.f.s.c.adapter.AdapterBeanFactory   : Servlet CdsODataV4Servlet mapped to /odata/v4
    2024-12-06T14:02:30.391Z  INFO 10998 --- [  restartedMain] c.s.c.f.s.c.adapter.AdapterBeanFactory   : Servlet IndexPageServlet mapped to /
    2024-12-06T14:02:30.393Z  INFO 10998 --- [  restartedMain] c.s.c.f.s.c.adapter.AdapterBeanFactory   : Servlet CdsFioriPreviewServlet mapped to /$fiori-preview
    2024-12-06T14:02:30.573Z  INFO 10998 --- [  restartedMain] c.s.c.services.impl.ServiceCatalogImpl   : Registered service PersistenceService$Default
    2024-12-06T14:02:30.614Z  INFO 10998 --- [  restartedMain] .s.c.a.o.v.m.p.EdmxProviderConfiguration : Initialized Default EDMX V4 Provider
    2024-12-06T14:02:30.619Z  INFO 10998 --- [  restartedMain] .s.c.a.o.v.m.p.EdmxProviderConfiguration : Initialized Default EDMX I18n Provider
    2024-12-06T14:02:30.650Z  INFO 10998 --- [  restartedMain] c.sap.cds.services.impl.utils.BuildInfo  : git.commit.id: 9d82be78fe5d02e889632e16057953cbfc609d5b
    2024-12-06T14:02:30.650Z  INFO 10998 --- [  restartedMain] c.sap.cds.services.impl.utils.BuildInfo  : maven.version: 3.4.1
    2024-12-06T14:02:30.689Z  INFO 10998 --- [  restartedMain] o.s.b.d.a.OptionalLiveReloadServer       : LiveReload server is running on port 35729
    2024-12-06T14:02:30.703Z  INFO 10998 --- [  restartedMain] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port 8080 (http) with context path '/'
    2024-12-06T14:02:30.709Z  INFO 10998 --- [  restartedMain] c.incident_management.Application        : Started Application in 1.725 seconds (process running for 2.035)
    ```

    You can see in the log output, the new file created two generic service providers: `ProcessorService` and `AdminService`. 

1. In the bottom right of your SAP Business Application Studio window, look for the popup **A service is listening to port 8080**.
 

2. Choose **Open in a New Tab**.

    <!-- border; size:540px --> ![Open in a new tab](./open-new-tab.png)

3. You see the generic `index.html` page:

    <!-- border; size:540px --> ![index.html](./index-java.png)

> You need to stop the CAP server with <kbd>Ctrl</kbd> + <kbd>C</kbd> and start it again with the `mvn cds:watch` command.

[OPTION END]

### Generate comma-separated values (CSV) templates

Since we already have an SQLite in-memory database that was automatically created in the previous step, let's now fill it with initial data.

1. Run the following command in the **incident-management** root folder of your project:

    ```bash
    cds add data
    ```

2. Check the output.

    ```bash
    Adding feature 'data'...
    Creating db/data/sap.capire.incidents-Addresses.csv
    Creating db/data/sap.capire.incidents-Customers.csv
    Creating db/data/sap.capire.incidents-Incidents.csv
    Creating db/data/sap.capire.incidents-Incidents.conversation.csv
    Creating db/data/sap.capire.incidents-Status.csv
    Creating db/data/sap.capire.incidents-Status.texts.csv
    Creating db/data/sap.capire.incidents-Urgency.csv
    Creating db/data/sap.capire.incidents-Urgency.texts.csv

    Successfully added features to your project.
    ```


    You can find the generated CSV templates within the **db** folder, in a newly created **data** folder.
     
### Fill in the initial data

> **Important distinction between initial data and test data**
>
> You need to distinguish between (real) initial data meant for production (configuration, code lists) and test data meant for development and testing purposes only. For more information, see [Initial vs Test Data](https://pages.github.tools.sap/cap/docs/guides/databases/initial-data#initial-vs-test-data).


Replace the respective generated CSV templates with the following content:

- `db/data/sap.capire.incidents-Addresses.csv`:

    ```csv
    ID,customer_ID,city,postCode,streetAddress
    17e00347-dc7e-4ca9-9c5d-06ccef69f064,1004155,Rome,00164,Piazza Adriana
    d8e797d9-6507-4aaa-b43f-5d2301df5135,1004161,Munich,80809,Olympia Park
    ff13d2fa-e00f-4ee5-951c-3303f490777b,1004100,Walldorf,69190,Dietmar-Hopp-Allee
    ```

- `db/data/sap.capire.incidents-Customers.csv`:

    ```csv
    ID,firstName,lastName,email,phone
    1004155,Daniel,Watts,daniel.watts@demo.com,+39-555-123
    1004161,Stormy,Weathers,stormy.weathers@demo.com,+49-020-022
    1004100,Sunny,Sunshine,sunny.sunshine@demo.com,+49-555-789
    ```

- `db/data/sap.capire.incidents-Incidents.conversation.csv`:

    ```csv
    ID,up__ID,timestamp,author,message
    2b23bb4b-4ac7-4a24-ac02-aa10cabd842c,3b23bb4b-4ac7-4a24-ac02-aa10cabd842c,1995-12-17T03:24:00Z,Harry John,Can you please check if battery connections are fine?
    2b23bb4b-4ac7-4a24-ac02-aa10cabd843c,3a4ede72-244a-4f5f-8efa-b17e032d01ee,1995-12-18T04:24:00Z,Emily Elizabeth,Can you please check if there are any loose connections?
    9583f982-d7df-4aad-ab26-301d4a157cd7,3583f982-d7df-4aad-ab26-301d4a157cd7,2022-09-04T12:00:00Z,Sunny Sunshine,Please check why the solar panel is broken.
    9583f982-d7df-4aad-ab26-301d4a158cd7,3ccf474c-3881-44b7-99fb-59a2a4668418,2022-09-04T13:00:00Z,Bradley Flowers,What exactly is wrong?
    ```

- `db/data/sap.capire.incidents-Incidents.csv`:

    ```csv
    ID,customer_ID,title,urgency_code,status_code
    3b23bb4b-4ac7-4a24-ac02-aa10cabd842c,1004155,Inverter not functional,H,C
    3a4ede72-244a-4f5f-8efa-b17e032d01ee,1004161,No current on a sunny day,H,N
    3ccf474c-3881-44b7-99fb-59a2a4668418,1004161,Strange noise when switching off Inverter,M,N
    3583f982-d7df-4aad-ab26-301d4a157cd7,1004100,Solar panel broken,H,I
    ```

- `db/data/sap.capire.incidents-Status.csv`:

    ```csv
    code,descr,criticality
    N,New,3
    A,Assigned,2
    I,In Process,2
    H,On Hold,3
    R,Resolved,2
    C,Closed,4
    ```

- `db/data/sap.capire.incidents-Urgency.csv`:

    ```csv
    code,descr
    H,High
    M,Medium
    L,Low
    ```

    > Notice that `cds add data` created eight files, while we're adding data to just six of them. We're leaving the files `sap.capire.incidents-Status.texts.csv` and `sap.capire.incidents-Urgency.texts.csv` empty because they hold translated text that are filled once the application is localized and translations are created.

Upon detecting these new files, the CAP server prints a message stating that the content of the files has been filled into the database automatically:

[OPTION BEGIN [Node.js]]

```bash
[cds] - connect to db > sqlite { database: ':memory:' }
  > init from db\data\sap.capire.incidents-Addresses.csv 
  > init from db\data\sap.capire.incidents-Customers.csv 
  > init from db\data\sap.capire.incidents-Incidents.csv 
  > init from db\data\sap.capire.incidents-Incidents.conversation.csv
  > init from db\data\sap.capire.incidents-Status.csv 
  > init from db\data\sap.capire.incidents-Status.texts.csv 
  > init from db\data\sap.capire.incidents-Urgency.csv 
  > init from db\data\sap.capire.incidents-Urgency.texts.csv 
/> successfully deployed to in-memory database.
```
> Make sure that your CAP server is still running. You can start it with `cds watch`.

Now that the database is filled with some initial data, you can send complex OData queries served by the built-in generic service providers. With the generic `index.html` page opened in your browser, paste the following queries at the end of the current URL and check the result:

- `/odata/v4/processor/Incidents`

    <!-- border; size:540px --> ![Incidents](./incidents.png)

- `/odata/v4/processor/Customers?$select=firstName&$expand=incidents`

    <!-- border; size:540px --> ![Incidents per customer](./incidents-per-customer.png)

[OPTION END]

[OPTION BEGIN [Java]]

```bash
2024-12-06T14:12:46.228Z  INFO 10998 --- [  restartedMain] c.s.c.s.impl.persistence.CsvDataLoader   : Filling sap.capire.incidents.Incidents.conversation from ../db/data/sap.capire.incidents-Incidents.conversation.csv
2024-12-06T14:12:46.229Z  INFO 10998 --- [  restartedMain] c.s.c.s.impl.persistence.CsvDataLoader   : Filling sap.capire.incidents.Incidents from ../db/data/sap.capire.incidents-Incidents.csv
2024-12-06T14:12:46.230Z  INFO 10998 --- [  restartedMain] c.s.c.s.impl.persistence.CsvDataLoader   : Filling sap.capire.incidents.Customers from ../db/data/sap.capire.incidents-Customers.csv
2024-12-06T14:12:46.231Z  INFO 10998 --- [  restartedMain] c.s.c.s.impl.persistence.CsvDataLoader   : Filling sap.capire.incidents.Status from ../db/data/sap.capire.incidents-Status.csv
2024-12-06T14:12:46.232Z  INFO 10998 --- [  restartedMain] c.s.c.s.impl.persistence.CsvDataLoader   : Filling sap.capire.incidents.Addresses from ../db/data/sap.capire.incidents-Addresses.csv
2024-12-06T14:12:46.233Z  INFO 10998 --- [  restartedMain] c.s.c.s.impl.persistence.CsvDataLoader   : Filling sap.capire.incidents.Urgency from ../db/data/sap.capire.incidents-Urgency.csv
2024-12-06T14:12:46.244Z  INFO 10998 --- [  restartedMain] o.s.b.d.a.OptionalLiveReloadServer       : LiveReload server is running on port 35729
2024-12-06T14:12:46.249Z  INFO 10998 --- [  restartedMain] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port 8080 (http) with context path '/'
2024-12-06T14:12:46.250Z  INFO 10998 --- [  restartedMain] c.incident_management.Application        : Started Application in 0.211 seconds (process running for 617.577)
```
> Make sure that your CAP server is still running. You can start it with `mvn cds:watch`.

Now that the database is filled with some initial data, you can send complex OData queries served by the built-in generic service providers. With the generic `index.html` page opened in your browser, paste the following queries at the end of the current URL and check the result:

- `/odata/v4/ProcessorService/Incidents`

    <!-- border; size:540px --> ![Incidents](./incidents.png)

- `/odata/v4/ProcessorService/Customers?$select=firstName&$expand=incidents`

    <!-- border; size:540px --> ![Incidents per customer](./incidents-per-customer.png)

[OPTION END]

> When you revisit the **Incidents** or the **Customers** endpoint, you see unformatted data instead of the nicely formatted output from above.
>
> ![No JSON Viewer](./incidents-unformatted.png)
>
> However, unformatted data doesn't mean you've made a mistake in the tutorial. Rather, this is the correct output without any formatting. If you'd like to see a formatted output in your browser, you can add an extension to your browser. Here are a few exemplary JSON formatters for different browsers:
>
> - [Chrome](https://chrome.google.com/webstore/detail/jsonvue/chklaanhfefbnpoihckbnefhakgolnmc)
> - [Microsoft Edge](https://microsoftedge.microsoft.com/addons/detail/jsonview/kmpfgkgaimakokfhgdahhiaaiidiphco)
> - [Safari](https://apps.apple.com/us/app/json-peep-for-safari/id1458969831?mt=12)


    
