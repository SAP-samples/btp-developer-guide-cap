# Run the application

## Introduction

The application development and deployment is completed and now it can be tested. The mock S/4HANA will be used to simulate sending of events which will be processed by the eventing implementation in the Incident Management application.

  
## Content

1. Access your Incident Management application.

2. In the new window, choose **Create** to create a new incident in your application

3. Enter the values for a new incident:
    - Title: <enter title name>
    - Customer: <enter your BusinessPartner>
    - Urgency: Low(L)
    - Status: New(N)

    Note: While Choosing customer copy the ID of the customer to a clipboard for a later use.
    
    Choose **Save** to finish

 ![Create Incident](./images/mock-incident.png)

4. Check the email address of your incident

 ![Create Incident](./images/mock-incident-mail.png)

5. Fetch the address Id of the Customer by executing the below request in Postman. Choose **GET** and copy URL to the field:
   
```
<The application route of the mock server\>/odata/v2/api-business-partner/A_BusinessPartner('<the-business-partner-id-of-your-created-incident')/to_BusinessPartnerAddress
```
  
  ![Fetch Address Id](./images/fetchAddressId.png)

6. Test your applicaton by executing below request in Postman. Choose **Patch** and copy URL to the field:

```
<The application route of the mock server\>/odata/v2/api-business-partner/A_BusinessPartner('<the-business-partner-id-of-your-created-incident\>') 
```

7. Copy below code to body

```json
{
    "to_BusinessPartnerAddress": [
        {
            "AddressID": "30662", //change to your AddressID
            "to_EmailAddress": [
                {
                    "AddressID": "30662", //change to your AddressID
                    "Person": "john",
                    "OrdinalNumber": "444",
                    "EmailAddress": "test@demo.com"
                }
            ]
        }
    ]
}
```

8. Make sure to choose **JSON** in dropdown and choose **Send**

 ![Test mock](./images/test-mock.png)

9. Go back to your Incident Management Application and refresh the page. Find the updated e-mail address displayed in the incident.

 ![Updated Business Partner](./images/mock-incident-new-mail.png)

 > Note: Often, remote operations should be delayed until the main transaction succeeded. Otherwise, the remote operations are also triggered in case of a rollback. To enable this, an outbox can be used to defer remote operations until the success of the current transaction. You can find more information about transactional outbox in the [documentation](https://cap.cloud.sap/docs/node.js/outbox)