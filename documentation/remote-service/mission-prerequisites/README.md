# Make sure prerequisites are fulfilled and all required systems are in place

## Prerequisites
* You have completed the Development and Deployment of Basic CAP application. This can be done in two different ways
    - Option 1 - By executing the [Basic tutorial](https://developers.sap.com/tutorials/deploy-to-cf.html).
    - Option 2 - [Execute the preliminary setup](../../prerequisite-for-sample/prerquites-for-sample.md).

* [Undeploy the application which was deployed to SAP BTP in previous steps](../../../prerequisite-for-sample/prerquites-for-sample.md#undeploy-the-application).

## Systems and Accounts

* [SAP S/4HANA Cloud](https://www.sap.com/products/erp/s4hana.html) system 
* [Optional] If you don't have an SAP S/4HANA Cloud system you can run this mission by installing a mock server. For the mock server, you would need 256MB of Cloud Foundry runtime.

### Additional Entitlements Required

Remote Service Integration to the developed CAP application requires the following additional [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US) in the SAP BTP cockpit:

| Service                           | Plan       | Number of Instances |
|-----------------------------------|------------|:-------------------:|
| SAP S/4HANA Cloud Extensibilty | api-access | 1 |






