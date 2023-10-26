# Make sure prerequisites are fulfilled and all required systems are in place

## Prerequisites
* You have the following options to develop and deploy a basic CAP application:
    - Option 1 - Go through the following tutorials based on the Incident Management application step by step and explore the source code and the administrative tasks.
    For Cloud Foundry Runtime:
       1. [Develop a Full-Stack CAP Application](https://developers.sap.com/group.cap-application-full-stack.html)
       2. [Deploy a Full-Stack CAP Application in SAP BTP, Cloud Foundry Runtime](https://developers.sap.com/group.deploy-full-stack-cap-application.html)

    - Option 2 - Go through the following tutorials to Download the Incident Management application  directly from GitHub repository
        1. Run the below command to clone the Incident Management Application

            ```sh
            git clone https://github.com/cap-js/incidents-app.git
            ```
        2. Rename the project to `Incident-Management`
        3. Navigate to **package.json** file from the project's root folder and modify the **name** to **incident-management**
        4. For Cloud Foundry
            - [Prepare for SAP BTP Development with Cloud Foundry Runtime](https://developers.sap.com/tutorials/prepare-btp-cf.html)
            - Follow untill [Add the UI Applicaiton](https://developers.sap.com/tutorials/deploy-to-cf.html#2d5dd378-1a41-4166-9a4b-75f8181ba71f) in [Deploy in SAP BTP, Cloud Foundry Runtime](https://developers.sap.com/tutorials/deploy-to-cf.html#2d5dd378-1a41-4166-9a4b-75f8181ba71f)
        5. For Kyma Runtime
            - [Execute the preliminary setup](../../prerequisite-for-sample/prerquites-for-sample.md#prepare-application-to-deploy-to-kymak8s).

> Undeploy your application by running the below command, if you had deployed it.
    For Cloud Foundry,
    ```sh
    cf undeploy <YOUR_MTA_ID> --delete-services
    ```

    For Kyma Runtime,
    ```sh
    helm uninstall <RELEASE_NAME> -n <YOUR_NAMESPACE>
    ```

## Systems and Accounts

* SAP S/4HANA Cloud system 
* [Optional] If you don't have an SAP S/4HANA Cloud system, you can complete this tutorial by installing a mock server. For the mock server, you would need 256MB of Cloud Foundry runtime.

### Additional Entitlements Required

Remote service integration to the developed CAP application requires the following additional entitlements and quotas in the SAP BTP cockpit:

| Service                           | Plan       | Number of Instances |
|-----------------------------------|------------|:-------------------:|
| SAP S/4HANA Cloud Extensibilty | api-access | 1 |

See [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US)




