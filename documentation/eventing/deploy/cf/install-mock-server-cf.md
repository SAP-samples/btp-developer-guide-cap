# Option 1 - Install Mock Server in SAP BTP, Cloud Foundry Runtime

## Prerequisite

* You have completed the Remote Service Integration tutorial.
* You have deployed the mock server in the SAP BTP, Cloud Foundry runtime.
* You have created a destination using the following steps [here](../../../remote-service/install-mock-server/install-mock-server-cf.md).

## Redeploy the Mock Server Application

In this section you would redeploy the mock server and bind it to the SAP Event Mesh instance so that the mock server can emit events. 

1. In the menu, choose **File** and then choose **Open Folder** from the dropdown menu.

2. To open the mock server project, choose **projects** &rarr; **cloud-extension-ecc-business-process** and then choose **Open**.

3. In the project folder, open the **mta.yaml** file.

    1. Add the following code snippet in the `resources` section:
        ```yaml
        - name: incident-management-messaging
          type: org.cloudfoundry.existing-service
        ```

    2. Add the following entry in the `requires` section of the `mock-srv` module:

        ```yaml
            - name: incident-management-messaging
        ```

4. In the project folder, right-click the **mta.yaml** file and choose **Build MTA Project**.

5. When the project is built successfully, you will see a new **mta_archives** folder in your project with the **Mockserver_1.0.0.mtar** file inside. Right-click that file and choose **Deploy MTA Archive**.

## Deploy the Incident Management Application

1. In the menu, choose **File** and then choose **Open Folder** from the dropdown menu.
1. To open the Incident Management project, choose **projects** &rarr; **incident-nanagement** and then choose **Open**.
2. Open the **package.json** and change the credentials to:
   
    ```json
    "credentials": {
            "destination": "<destination_name>",
            "path": "/v2/odata/v4/api-business-partner"
          }
    ```
>Note: You have to replace **destination_name** with the name of the destination created while deploying the mock server in the SAP BTP, Cloud Foundry runtime.

2. Follow the steps in the [Deploy to Cloud Foundry](./deploy-to-cf.md) tutorial.
