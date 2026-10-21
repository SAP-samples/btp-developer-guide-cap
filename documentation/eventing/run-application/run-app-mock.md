# Run the application

## Introduction

The application development and deployment are complete and now it can be tested. The mock S/4HANA will be used to simulate sending of events which will be processed by the eventing implementation in the Incident Management application.

  
## Content

> **Before you begin:** Ensure that the **support** role collection is assigned to your user. Without the required role, the Incident Management application may display a blank page and requests to `ProcessorService` may return `HTTP 403 Forbidden`. See [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html).

1. Access your Incident Management application.

2. In the new window, choose **Create** to create a new incident in your application

3. Enter the values for a new incident:
    - Title: <enter title name>
    - Customer: <enter your BusinessPartner>
    - Urgency: Low(L)
    - Status: New(N)

    Note: When selecting a customer, copy the customer ID to a clipboard for a later use.
    
    Choose **Save** to finish. Ensure the incident is saved and is not left as a draft before proceeding with the eventing test.

 ![Create Incident](./images/mock-incident.png)

4. Check the email address of your incident

 ![Create Incident](./images/mock-incident-mail.png)

5. Retrieve the customer's AddressID by sending the following request in Postman. Choose **GET** and copy URL to the field:
   
```
<mock-server-route>/odata/v2/api-business-partner/A_BusinessPartner('<your-business-partner-id>')/to_BusinessPartnerAddress
```
  
  ![Fetch Address Id](./images/fetchAddressId.png)

  Note the `AddressID` returned in the response. You will use this value in Step 7.

6. Test your application by sending the following request in Postman. Choose **PATCH** and copy URL to the field:

```
<mock-server-route>/odata/v2/api-business-partner/A_BusinessPartner('<your-business-partner-id>')
```

7. Copy the following JSON into the request body

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

8. Make sure to select **JSON** from the dropdown and choose **Send**

 ![Test mock](./images/test-mock.png)

9. Go back to your Incident Management Application and refresh the page. Find the updated e-mail address displayed in the incident.

 ![Updated Business Partner](./images/mock-incident-new-mail.png)

 > Note: Often, remote operations should be delayed until the main transaction succeeded. Otherwise, the remote operations are also triggered in case of a rollback. To enable this, an outbox can be used to defer remote operations until the success of the current transaction. You can find more information about transactional outbox in the [documentation](https://cap.cloud.sap/docs/node.js/outbox)