# Option 1 - Deploy and Run the Application on Cloud Foundry

## Prerequisites
Refer to [prerequisite-for-sample](../prerequisite-for-sample/prerquites-for-sample.md) to prepare your sample for deploying to CF.
## Use SAP Audit Log Service

While we simply dumped audit log messages to stdout in local development, we'll be using the **SAP Audit Log Service** on SAP BTP in **production**.

### Setup Instance and Deploy App
Here is what you need to do additionally, to integrate with SAP Audit Log Service:

1. Add the service instance as existing resource to your **mta.yml**. 
    ```yaml
    resources:
    - name: incidents-auditlog
      parameters:
        service-plan: premium
        service: auditlog
      type: org.cloudfoundry.managed-service
    ```
2. Bind the service to `incident-management-srv` in its **requires** section.
    ```yaml
      requires:
      - name: incidents-auditlog
    ```
3. Build the mtar and deploy your application.
```bash
mbt build
```
4. Check if the mtar has been created in the mta_archives folder and do: 

```bash
cf deploy mta_archives/incident-management_1.0.0.mtar
```
 
4. After successful deployment, you can go to SAP BTP Subaccount-> Spaces -> Your Space, and see the application up and running.
5. You can click on service binding and see the services bind to your application. Here auditlog service is binded to your application
![](./images/app-and-service.png)
6. You have to [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html) to be able to access the application via the URL.

### Test your application.
1. We will be using API Testing tools like [Postman](https://www.postman.com/) or [Insomnia](https://insomnia.rest/) to test and generate auditlog.
2. In order to access the below endpoint, the user needs `support` role and `xsuaa token` has to be passed in the header.

3. To generate the token, use the following credentials from your XSUAA Instance Service Key: `clientId`, `clientsecret`, `url/oauth/token`.
![](./images/xsuaa-cf.png)
4. Use postman and generate access token. Set authorization type as `OAuth 2.0` , `cf username` ,`cf password` and generate access token.
![](./images/access-token.png)

5. Use `https://<org>-<space>-incidents-srv.cfapps.sap.hana.ondemand.com/odata/v4/processor/Customers` and send the request( Step 7 in the above screenshot) and if successful, you will get the list of customers as response:
```
{
    "@odata.context": "$metadata#Customers",
    "value": [
        {
            "ID": "2b87f6ca-28a2-41d6-8c69-ccf16aa6389d",
            "createdAt": null,
            "createdBy": null,
            "modifiedAt": null,
            "modifiedBy": null,
            "firstName": "Sunny",
            "lastName": "Sunshine",
            "email": "sunny.sunshine@demo.com",
            "phone": "+01-555-789",
            "creditCardNo": null,
            "name": "Sunny Sunshine"
        },
        {
            "ID": "8fc8231b-f6d7-43d1-a7e1-725c8e988d18",
            "createdAt": null,
            "createdBy": null,
            "modifiedAt": null,
            "modifiedBy": null,
            "firstName": "Daniel",
            "lastName": "Watts",
            "email": "daniel.watts@demo.com",
            "phone": "+44-555-123",
            "creditCardNo": null,
            "name": "Daniel Watts"
        },
        {
            "ID": "feb04eac-f84f-4232-bd4f-80a178f24a17",
            "createdAt": null,
            "createdBy": null,
            "modifiedAt": null,
            "modifiedBy": null,
            "firstName": "Stormy",
            "lastName": "Weathers",
            "email": "stormy.weathers@demo.com",
            "phone": null,
            "creditCardNo": null,
            "name": "Stormy Weathers"
        }
    ]
}
```
6. On reading the customer data( which we have annotated with @PersonalData), there will be a audit log entry in CF, which we will be retrieving in next step. 

