# Make sure prerequisites are fulfilled and all required systems are in place

## Prerequisites
* You have completed the [Remote Service Integration](../../remote-service/README.md) tutorial.
* Undeploy the application that was deployed to SAP BTP in the Remote Service Integration tutorial.
    - If you use SAP BTP, Cloud Foundry runtime: undeploy the application using the following command:
      
        ```sh
        cf undeploy <YOUR_MTA_ID> --delete-services
        ```
     
        > **Note:** Replace `YOUR_MTA_ID` in the command above with the `ID` from **mta.yaml** file.

    - If you use SAP BTP, Kyma runtime: undeploy the application using the following command:

        ```sh
        helm uninstall <RELEASE_NAME> -n <YOUR_NAMESPACE>
        ```

## Systems and Accounts

* Have an SAP S/4HANA Cloud system 
* [Optional] If you don't have an access to an SAP S/4HANA Cloud system, you can deploy and run the Incident Management application with a mock server. For deploying the mock server, you would need either SAP BTP, Cloud Foundry runtime (256 MB) or a Kyma cluster. The mock Server exposes a mock SAP S/4HANA Cloud entity (for example, Business Partner) as oData API  along with the sample data required for the application. The installation of the mock server is only needed if you want to test your application deployed in SAP BTP, Cloud Foundry runtime or SAP BTP, Kyma runtime. You can also use the mock server for local development and  testing.

## Additional Entitlements Required

Adding eventing to the developed CAP application requires the following additional [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US) in the SAP BTP cockpit:

| Service                           | Plan       | Number of Instances |
|-----------------------------------|------------|:-------------------:|
| SAP S/4HANA Cloud Extensibilty | api-access | 1 |
| SAP S/4HANA Cloud Extensibilty | messaging | 1 |
| SAP Event Mesh| default | 1 |









