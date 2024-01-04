# Make sure prerequisites are fulfilled and all required systems are in place

## Prerequisites
* Complete the [Remote Service Integration](../../remote-service/README.md) tutorial.
* Undeploy the application that was deployed to SAP BTP in the Remote Service Integration tutorial.
    - Undeploy the application using the following command:
      
        ```sh
        cf undeploy <YOUR_MTA_ID> --delete-services
        ```
     
        > **Note:** Replace `YOUR_MTA_ID` in the command above with the `ID` from **mta.yaml** file.

## Systems and Accounts

* You have an SAP S/4HANA Cloud system 

## Additional Entitlements Required

Adding eventing to the developed CAP application requires the following additional entitlements and quotas in the SAP BTP cockpit:

| Service                           | Plan       | Number of Instances |
|-----------------------------------|------------|:-------------------:|
| SAP S/4HANA Cloud Extensibility | api-access | 1 |
| SAP S/4HANA Cloud Extensibility | messaging | 1 |
| SAP Event Mesh| default | 1 |


See [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US).

* While adding entitlement **SAP S/4HANA Cloud Extensibility**, please select the appropriate system under **Service Details: SAP S/4HANA Cloud Extensibility** dropdown.
* In the checkbox, check the **api-access** and **messaging** under Available Plans and add the service plans.




