# Deploy and Run the Incident Management Application with Mock Server

## Usage Scenario

If you don't have access to an SAP S/4HANA Cloud system, you can deploy and run the application with the installed mock server.

## Deploy the Incident Management Application

1. Navigate to the Incident Management application and change *credentials* of `API_BUSINESS_PARTNER` in *package.json* to 
    ```json
    "credentials": {
            "destination": "<destination_name>",
            "path": "/odata/v2/api-business-partner"
          }
    ```
**Note** - As **destination_name**, you must enter the name of the destination created while installing the mock server to SAP BTP Kyma runtime.

2. Follow the steps in [Deploy to Kyma tutorial](./deploy-to-kyma.md), but skip the steps for the **Remote Service Configuration**.
>Make sure you deploy the Incident Management application to the same namespace as the mock server.
