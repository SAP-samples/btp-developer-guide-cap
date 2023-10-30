# Implement Audit Logging


## Extending the Customer Entity 

For audit logging, we will be extending the customer entity with some potentially sensitive properties.
 - Add a file `extensions.cds` in `/db` folder with the following content;
   ```js
    using from './schema';
    using {
      cuid,
      managed
    } from '@sap/cds/common';

    entity sap.capire.incidents.Addresses : cuid, managed {
      customer      : Association to sap.capire.incidents.Customers;
      city          : String;
      postCode      : String;
      streetAddress : String;
    }

    extend sap.capire.incidents.Customers with {
      creditCardNo : String(16) @assert.format: '^[1-9]\d{15}$';
      addresses    : Composition of many sap.capire.incidents.Addresses
                   on addresses.customer = $self;
    };

   ```
   - Here we are extending the **Customer** entity and adding `Addresses` and `creditCardNo` properties. These two are only used for audit logging purposes.

## Adding Admin Service to Expose Customers Entity

Add a file `admin-service.cds` in `/srv` folder and update it with following code:
```js
    using { sap.capire.incidents as my } from '../db/extensions';

    @requires: 'admin'
    service AdminService {

      entity Customers as projection on my.Customers;

    }
```
  
## Annotating Personal Data

In order to automate audit logging, personal data management, and data retention management as much as possible, the first and frequently only task to do as an application developer is to identify entities and elements (potentially) holding personal data using **@PersonalData** annotations.
<br/>
we annotate our domain model in a separate file `srv/data-privacy.cds` and fill it with the following content:

```js
using {sap.capire.incidents as my} from './admin-service';
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

Add the following plugin package to your project

```sh
npm add @cap-js/audit-logging
```

The package is a *cds-plugin* and thereby auto-writes many things so configurations and annotations are reduced to a minimum. 

## Test Locally
The steps above is all you need to automatically log personal data-related events. 

1. Start the server.
```bash
cds watch
```
2. Create a file `request.http` with the following content:
```http
@host = http://localhost:4004

#####
#
# ProcessorService
#

### Reading sensitive data (creditCardNo) by default - NOT recommended!
GET {{host}}/odata/v4/processor/Customers
Authorization: Basic incident.support@tester.sap.com:initial

### Recommendation: Avoid reading sensitive data by explicitly selecting the fields you need
GET {{host}}/odata/v4/processor/Customers?$select=name
Authorization: Basic incident.support@tester.sap.com:initial

#####
#
# AdminService
#

### Creating a customer with personal data
# @name create_customer
POST {{host}}/odata/v4/admin/Customers
Authorization: Basic alice:wonderland
Content-Type: application/json

{
  "ID": "{{$guid}}",
  "firstName": "Bob",
  "lastName": "Builder",
  "email": "bob.builder@example.com"
}

### Updating a customer with personal data details
@customer = {{create_customer.response.body.ID}}
PATCH {{host}}/odata/v4/admin/Customers({{customer}})
Authorization: Basic alice:wonderland
Content-Type: application/json

{
  "addresses": [
    {
      "city": "Walldorf",
      "postCode": "69190",
      "streetAddress": "Dietmar-Hopp-Allee 16"
    }
  ]
}
```

3. Send the requests and observe the response having logs from `[audit-log]` with `PersonalDataModified` and `SensitiveDataRead` events.

## Next Step
Now you have implemented audit logging, tested the application locally and it's time to deploy it to SAP BTP.
[Deploy to SAP BTP](./3-deploy-to-btp.md). 
