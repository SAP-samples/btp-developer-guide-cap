# Run the Incident Management Application with Mock Server

## Situation

If don't have an access to an SAP S/4HANA Cloud system you can have the option to deploy and run the application with the installed mock server.

## Deploy the Incident Management Application

1. Navigate to incident management app and change credentials in package.json to 
    ```json
    "credentials": {
            "destination": "<destination_name>",
            "path": "/v2/odata/v4/api-business-partner"
          }
    ```
**Note** - As **destination_name** you must enter the name of the destination created while installing mock server to SAP BTP Cloud Foundry Runtime.

2. Follow the steps in the [Deploy to Kyma tutorial](./deploy-to-kyma.md), but skip the steps for the **Remote Service Configuration**.
>Make sure you deploy the incident management application to the same namespace as the mock server.

3. Now you can build and deploy the Incident Management Application