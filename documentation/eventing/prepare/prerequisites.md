# Make sure prerequisites are fulfilled and all required systems are in place

## Prerequisites
* You have completed the [Remote Service Integration Tutorial](../../remote-service/README.md)

* [Undeploy the application which was deployed to SAP BTP in previous Remote Service Integration Tutorial](../../prerequisite-for-sample/prerquites-for-sample.md#undeploy-the-application).

## Systems and Accounts

* [SAP S/4HANA Cloud](https://www.sap.com/products/erp/s4hana.html) system 
* [Optional] If you don't have an access to an SAP S/4HANA Cloud system you can have the option to deploy and run the Incident Management application with a mock server. For deploying the mock server, you would need either Cloud Foundry runtime (256 MB) or a Kyma cluster. Mock Server exposes a mock SAP S/4HANA entity (e.g Business Partner) as oData api  along with the sample data required for the application. This installation of the mock server is only needed if you want to test your application deployed for SAP BTP CF or Kyma runtime. For local development and  testing you could use the local mock server.

### Additional Entitlements Required

Adding Eventing to the developed CAP application requires the following additional [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US) in the SAP BTP cockpit:

| Service                           | Plan       | Number of Instances |
|-----------------------------------|------------|:-------------------:|
| SAP S/4HANA Cloud Extensibilty | api-access | 1 |
| SAP S/4HANA Cloud Extensibilty | messaging | 1 |
| SAP Event Mesh| default | 1 |









