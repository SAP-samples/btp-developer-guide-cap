# Make sure prerequisites are fulfilled and all required systems are in place

## Prerequisites
* Complete the [Remote Service Integration](../../remote-service/remote-service-mock-cf.md) tutorial.
* Undeploy the application that was deployed to SAP BTP in the Remote Service Integration tutorial.
    - Undeploy the application using the following command:
      
        ```sh
        cf undeploy <YOUR_MTA_ID> --delete-services
        ```
     
        > **Note:** Replace `YOUR_MTA_ID` in the command above with the `ID` from **mta.yaml** file.

## Mock Server 

* You have to build and deploy mock server on SAP BTP Cloud Foundry Runtime.

## Additional Entitlements Required

Adding eventing to the developed CAP application requires the following additional entitlements and quotas in the SAP BTP cockpit:

| Service                           | Plan       | Number of Instances |
|-----------------------------------|------------|:-------------------:|
| SAP Event Mesh| default | 1 |


See [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US).







