# Implement Audit Logging
  
## Annotate Personal Data

In order to automate audit logging, personal data management, and data retention management as much as possible, the first and frequently only task to do as an application developer is to identify entities and elements (potentially) holding personal data using **@PersonalData** annotations.
<br/>
Annotate the domain model in a separate file `srv/data-privacy.cds` and fill it with the following content:

```js
using {sap.capire.incidents as my} from './services';
using {
  cuid,
  managed
} from '@sap/cds/common';


annotate my.Customers with @PersonalData: {
  EntitySemantics: 'DataSubject',
  DataSubjectRole: 'Customer',
} {
  ID         @PersonalData.FieldSemantics : 'DataSubjectID';
  firstName     @PersonalData.IsPotentiallyPersonal;
  lastName      @PersonalData.IsPotentiallyPersonal;
  email         @PersonalData.IsPotentiallyPersonal;
  phone         @PersonalData.IsPotentiallyPersonal;
  creditCardNo @PersonalData.IsPotentiallySensitive;
}

annotate my.Addresses with @PersonalData: {
  EntitySemantics: 'DataSubjectDetails'
} {
  customer      @PersonalData.FieldSemantics: 'DataSubjectID';
  city          @PersonalData.IsPotentiallyPersonal;
  postCode      @PersonalData.IsPotentiallyPersonal;
  streetAddress @PersonalData.IsPotentiallyPersonal;
}


```
## Add the Plugin

1. Add the following plugin package to your project

```sh
npm add @cap-js/audit-logging
```

2. Build the application by executing the below command

```sh
npm i
```

The package is a *cds-plugin* and thereby auto-writes many things so configurations and annotations are reduced to a minimum. 

## Test Locally
Let's try out how the audit log works by executing some local rest calls.

1. Take care that your server is up and running. If not, start the server via:

   ```bash
   cds watch
   ```

2. We use the SAP Business Application Studio Rest Extension to run Rest Calls.

   Execute the following command to add `.http` files with sample read and write requests.
    ```shell
    cds add http --filter AdminService
    ```
   - This will add the `AdminService.http` file in `test/http` folder at the root directory.
   
> [!NOTE]
> Change the `username` in AdminService.http to `alice`.
   
3. Let's have a close look and send requests and check which audit logs they create.

   - Open `test/http/AdminService.http` file and run the request to read all Customers.
     ![](./images/auditlog-local.png)

   In the Terminal log you will find several audit-log entries. On for each Customer's entity.

   Here is a sample audit log `SensitiveDataRead` for 1 customer entity. In your log, the timestamp matches the current timestamp.

     ```
       [odata] - GET /odata/v4/admin/Customers
       [cds] - connect to audit-log > audit-log-to-console
       [audit-log] - SensitiveDataRead: {
       data_subject: {
       id: { ID: '1004100' },
       role: 'Customer',
       type: 'AdminService.Customers'
       },
       object: { type: 'AdminService.Customers', id: { ID: '1004100' } },
       attributes: [ { name: 'creditCardNo' } ],
       uuid: '7a130a4e-bec7-4597-9c5c-250dffd3b274',
       tenant: undefined,
       user: 'alice',
       time: 2025-05-26T08:41:38.516Z
       }
       [audit-log] - SensitiveDataRead: {
       data_subject: {
       id: { ID: '1004155' },
       role: 'Customer',
       type: 'AdminService.Customers'
       },
       object: { type: 'AdminService.Customers', id: { ID: '1004155' } },
       attributes: [ { name: 'creditCardNo' } ],
       uuid: 'ce9d7e56-77bf-4554-a3d5-2dd020f156f7',
       tenant: undefined,
       user: 'alice',
       time: 2025-05-26T08:41:38.516Z
       }
     ```

   - Run the request which only selecting the property name. As the name property is not annotated to be personal data, you will not gain any audit-log entry in the server console.
   
  > [!NOTE]
  > Before running `post` or `patch` requests, please remove `creditCardNo` field from the request body in `AdminService.http` file.

   - Now, create a new customer to get `PersonalDataModified` audit logs with current timestamp:

    ```
    [odata] - POST /odata/v4/admin/Customers
    [audit-log] - PersonalDataModified: {
      data_subject: {
        id: { ID: 'b7f481cf-5c5f-4588-be8b-ceb45a34d48e' },
        role: 'Customer',
        type: 'AdminService.Customers'
      },
      object: {
        type: 'AdminService.Customers',
        id: { ID: 'b7f481cf-5c5f-4588-be8b-ceb45a34d48e' }
      },
      attributes: [
        { name: 'firstName', new: 'Bob' },
        { name: 'lastName', new: 'Builder' },
        { name: 'email', new: 'bob.builder@example.com' }
      ],
      uuid: 'f3372dd1-f475-44c9-b805-0924e6612505',
      tenant: 't1',
      user: 'alice',
      time: 2024-02-15T14:51:12.243Z
    }
    ```

  - Run the PATCH command to add an address as well and you will get `PersonalDataModified` audit-log.

## Adding Custom Audit Logs
As part of audit logs, there can be cases where you want to genereate custom audit logs. For example if you want to log 403 - Forbidden events when an user is not having roles but is still trying to access certain data. 
This can be achieved by adding custom handlers in a CAP application. 


## Add custom Audit Log into a CAP Application
CAP provides different handlers that can be used to catch events and add custom logic like custom audit logs. To do so add the following:

1. Create a file `server.js` at root of your CAP application.
2. Add the following code:

    ```javascript
    const cds = require('@sap/cds')

    let audit

    cds.on('served', async () => {
    audit = await cds.connect.to('audit-log')
    })

    const audit_log_403 = (resource, ip) => {
    // we need to start our own tx because the default tx may be burnt
    audit.tx(async () => {
        await audit.log('SecurityEvent', {
        data: {
            user: cds.context.user?.id || 'unknown',
            action: `Attempt to access restricted resource "${resource}" with insufficient authority`
        },
        ip
        })
    })
    }

    // log for non-batch requests
    cds.on('bootstrap', app => {
    app.use((req, res, next) => {
        req.on('close', () => {
        if (res.statusCode == 403) {
            const { originalUrl, ip } = req
            audit_log_403(originalUrl, ip)
        }
        })
        next()
    })
    })

    // log for batch subrequests
    cds.on('serving', srv => {
    if (srv instanceof cds.ApplicationService) {
        srv.on('error', (err, req) => {
        if (err.code == 403) {
            const { originalUrl, ip } = req.http.req
            if (originalUrl.endsWith('/$batch')) audit_log_403(originalUrl.replace('/$batch', req.req.url), ip)
        }
        })
    }
    })

    module.exports = cds.server
    ```

Here in this custom code we are trying to generate `security-events` for  `403` `forbidden` events. This can be modified to include any other events as well.

## Test Locally

Let's try out how the custom audit log works by executing some local rest calls.

1. Take care that your server is up and running. If not, start the server via:

   ```bash
   cds watch
   ```

2. We use the SAP Business Application Studio Rest Extension to run Rest Calls.

   In the `package.json` remove `admin` role from user `alice`.

   Now send the following request in `test/http/AdminService.http`:

   ```sh
   ### Customers
   # @name Customers_GET
   GET {{server}}/odata/v4/admin/Customers
   Authorization: Basic {{username}}:{{password}}

   ```
   
   > In the above request we have removed the `admin` role from the user `alice` and hence it should throw 403 error, Generating custom audit logs.
   

   In the Editor several links ```Send Request``` are appearing. The response will appear on the right side.

   Check which port your server is listening on. Update the ``@host`` reference if necessary.

3. Let's have a close look and send requests and check which audit logs they create.

   Run the request to read all Customers. In the Console log you see output like this:

   ```sh
   [odata] - GET /odata/v4/admin/Customers 
   [error] - 403 - Error: Forbidden
       at requires_check (/Users/I524944/IdeaProjects/ams-external/cds9/node_modules/@sap/cds/lib/srv/protocols/http.js:54:32)
       at http_log (/Users/I524944/IdeaProjects/ams-external/cds9/node_modules/@sap/cds/lib/srv/protocols/http.js:42:59) {
     code: '403',
     reason: "User 'alice' is lacking required roles: [admin]",
     user: User { id: 'alice', roles: { support: 1 } },
     required: [ 'admin' ]
   }
   [audit-log] - SecurityEvent: {
     data: {
       user: 'alice',
       action: 'Attempt to access restricted resource "/odata/v4/admin/Customers" with insufficient authority'
     },
     ip: '::ffff:127.0.0.1',
     uuid: '1109134c-64db-42f8-a780-2dde61cf6821',
     tenant: undefined,
     user: 'alice',
     time: 2025-05-28T04:59:43.653Z
   }
   ```
Here our custom handler is generating these custom `security-events`.