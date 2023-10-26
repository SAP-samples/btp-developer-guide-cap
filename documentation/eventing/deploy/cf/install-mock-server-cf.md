# Option 1 - Install Mock Server in SAP BTP Cloud Foundry Runtime

## Pre requisite
The Remote Service Integration tutorial was executed and mock server was deployed on CF and destination was created following steps [here](../../../remote-service/install-mock-server/install-mock-server-cf.md)

## Re-Deploy the Mock Server Application

In this section you would redeploy the mock server and bind it to Event Mesh instance so that mock server can emit events. 
1. In the menu, choose **File** and then choose **Open Folder** from the dropdown menu.

2. To open the mock server project, choose **projects** &rarr; **cloud-extension-ecc-business-process** and then choose **Open**.

3. In the project folder, open **mta.yaml** file

    - add the below code snippet to the **resources** section
        ```yaml
        - name: inicdent-management-messaging
          type: org.cloudfoundry.existing-service
        ```

    - Adds the below entry in the `requires` section of `mock-srv` module

        ```yaml
            - name: inicdent-management-messaging
        ```

4. In the project folder, right-click the **mta.yaml** file and choose **Build MTA Project**.

5. When the project is built successfully, you will see a new **mta_archives** folder in your project with the **Mockserver_1.0.0.mtar** file inside. Right-click that file and choose **Deploy MTA Archive**.

## Deploy the Incident Management Application
1. In the menu, choose **File** and then choose **Open Folder** from the dropdown menu.
1. To open the Incident Managemnt project, choose **projects** &rarr; **incident-nanagement** and then choose **Open**.
2. Navigate to package.json and change credentials to 
    ```json
    "credentials": {
            "destination": "<destination_name>",
            "path": "/v2/odata/v4/api-business-partner"
          }
    ```
**Note** - As **destination_name** you must enter the name of the destination created while installing mock server to SAP BTP Cloud Foundry Runtime.

2. Follow the steps in the [Deploy to Cloud Foundry tutorial](./deploy-to-cf.md).
