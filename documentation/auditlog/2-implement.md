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

Add the following plugin package to your project

```sh
npm add @cap-js/audit-logging
```

The package is a *cds-plugin* and thereby auto-writes many things so configurations and annotations are reduced to a minimum. 

## Test Locally
The steps above is all you need to automatically log personal data-related events. 

1. Create a file `request.http` with the following content:
   
    ```
    
    @host = http://localhost:4004

    ### Service

    ### Reading sensitive data (creditCardNo) by default - NOT recommended!
    
    GET {{host}}/odata/v4/processor/Customers
    Authorization: Basic alice:wonderland

    ### Recommendation: Avoid reading sensitive data by explicitly selecting the fields you need
    GET {{host}}/odata/v4/processor/Customers?$select=name
    Authorization: Basic alice:wonderland

    ### AdminService

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
    PATCH {{host}}/odata/v4/admin/Customers('{{customer}}')
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
    
3. Add `admin` role to  `alice` in `package.json`.
    ```json
    "alice": {
                  "roles": ["support", "admin"]
                }   
    ```
    > User need `admin` role to access `admin` service and modify the customer's details.
4. Start the server.
    ```bash
      cds watch
    ```
5. Send the requests and observe the response having logs from `[audit-log]` with `PersonalDataModified` and `SensitiveDataRead` events.
