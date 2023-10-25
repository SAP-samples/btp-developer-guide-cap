# Run the Incident Management Application with Mock Server

## Situation

If you don't have an access to an SAP S/4HANA Cloud system you can have the option to deploy and run the application with the installed mock server.

## Deploy the Incident Management Application

1. Navigate to incident management app and change credentials of **API_BUSINESS_PARTNER** in package.json to 

    ```json
    "credentials": {
            "destination": "<destination_name>",
            "path": "/v2/odata/v4/api-business-partner"
          }
    ```
**Note** - As **destination_name** you must enter the name of the destination created while installing mock server to SAP BTP Cloud Foundry Runtime.

2. You can follow **Build CAP Node.js Image** to rebuild the image and **Deploy Helm Chart** in the [Deploy to Kyma tutorial](./deploy-to-kyma.md) to deploy the Incident Management Application.