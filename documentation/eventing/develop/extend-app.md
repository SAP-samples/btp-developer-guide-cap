# Extend the Incident Management Application with Eventing

## Introduction 
In this chapter you will add code , so that the CAP based application can listen and react to events from your SAP S/4HANA Cloud system.  
 
First you will need to add event definitions for the SAP S/4HANA events.


## Prerequisites

* You have finished the [Remote Service Integration](../../remote-service/README.md) Tutorial

  
## Content

1. Go back to your CAP project's root folder.

2. Create a topic annotation for processing events. For this open `srv/external` folder and create a new file called `API_BUSINESS_PARTNER.js` and add the below code snippet.  

```js
module.exports = function () {
    const { A_AddressEmailAddress, A_BusinessPartner } = this.entities;
   
    this.after('UPDATE', A_BusinessPartner, async data => {
      const messaging =  await cds.connect.to('messaging');
      const event = { BusinessPartner: data.BusinessPartner }
      console.log('>> BusinessPartner.Changed')
      await messaging.emit('sap.s4.beh.businesspartner.v1.BusinessPartner.Changed.v1', event);
    })
  }
```

3. Open `package.json` file in the root folder of the project and copy the code snippet to the `requries` section of the file. This will add SAP Event Mesh service as a dependency to your applicaton

```json
"messaging": {
        "kind": "local-messaging",
        "[production]": {
          "kind": "enterprise-messaging-shared",
          "format": "cloudevents"
        }
      }
```

5. Open `srv/processor-service.js` file and add the below code snippet to `init` method to set up an event listner for the BusinessPartnerChanged event

```js
this.messaging = await cds.connect.to('messaging');
    this.messaging.on('sap.s4.beh.businesspartner.v1.BusinessPartner.Changed.v1', async ({ event, data }) => await this.onBusinessPartnerChanged(event, data))
```

6. In `srv/processor-service.js` add the a method to update the changed Business Partner

```js
async onBusinessPartnerChanged(event, data){
    const {Customers, BusinessPartnerAddress, EmailAddress} = this.entities;
    //If Business Partner exists in Cache, then update
    console.log('<< received', event, data)
    const Id = data.BusinessPartner;
    console.log("BusinessPartnerID", Id);
    var customer =  await this.S4bupa.run(SELECT.one(BusinessPartnerAddress, address => {
      address('*'),
      address.email(emails => {
        emails('*')})
      }).where({BusinessPartner: Id}));
    console.log("customer after read email", customer.email[0].email);
    customer.email = customer.email[0].email
    if(customer){
      const result= await cds.run(UPDATE(Customers).where({ID: customer.ID}).set({email:customer.email}));
      console.log("result",result);
    }
  }
```

7. Navigate to `app/incidents`folder  and create a new file `field.cds`.
8. To see your changes getting replicated in user interface open `app/incidents/field.cds` and add the below code snippet

```cds
  using ProcessorService as service from '../../srv/processor-service';
  using from './annotations.cds';
  annotate service.Incidents with @(
  /*adding email to the object page enables users to view the
  changes recieved via Messaging/Eventing*/
  UI.FieldGroup #GeneratedGroup1 : {
  Data : [...,
    {
      $Type : 'UI.DataField',
      Value : customer.email,
      Label : '{i18n>email}'
    }
  ]
  });

  annotate service.Customers with {
    email @readonly
  };  
```

8. Navigate to `app` folder and add the below declaration to `services.cds`
  ```cds
  using from './incidents/field';
  ```
