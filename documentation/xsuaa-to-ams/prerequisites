# Make sure prerequisites are fulfilled and all required systems are in place

## Prerequisites

1. Develop a basic full-stack CAP application by following the below group of tutorials based on the Incident Management application step by step and explore the source code. See [Develop a Full-Stack CAP Application](https://developers.sap.com/group.cap-application-full-stack.html).

2. (Optional) If you have not deployed this application, do the following:
     1. [Prepare for SAP BTP Development with Cloud Foundry Runtime](https://developers.sap.com/tutorials/prepare-btp-cf.html).
     2. Follow until [Add the UI Applicaiton](https://developers.sap.com/tutorials/deploy-to-cf.html#2d5dd378-1a41-4166-9a4b-75f8181ba71f) in [Deploy in SAP BTP, Cloud Foundry Runtime](https://developers.sap.com/tutorials/deploy-to-cf.html#2d5dd378-1a41-4166-9a4b-75f8181ba71f)

3. (Optional) If you have deployed this application, undeploy your application by running the following command:
    `cf undeploy <YOUR_MTA_ID> --delete-services`
   
## Systems and Entitlements Required

 - *[For local testing only]* To use the Authorization Management service, you must have `Java 11+` or a later version installed on your system.
     
     Authorization Management service uses `cds2dclv compiler which converts the `.cds` files to `.dcl` files consumed by Open Policy Agent (OPA) server. This `cds2dcl` compiler is a Java based program, so we need Java 11+ version installed on the machine.
     We don't need it when deploying on SAP BTP as the Cloud Authorization buildpack bundled along with application takes care of it.
   
 - Authorization Management service integration to the developed CAP application requires the following additional entitlements and quotas in the SAP BTP cockpit:

    | Service                           | Plan       | Number of Instances |
    |-----------------------------------|------------| :-------------------:|
    | Cloud Identity Service | application | 1 |

   See [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US).
   
 - Establish Identity Authentication trust. In your SAP BTP subaccount where the applications that will use Authorization Management service resides, establish trust to your SAP Identity Authentication tenant.
   
   NOTE: If you want to deploy a multi-tenant application, please be aware that the IAS tenant explicitly needs to be created with the *multi-tenant enablement* flag set.
   See [Establish Trust](https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/161f8f0cfac64c4fa2d973bc5f08a894.html).
   
 - The SAP Build Workzone has Identity Authentication enabled. See [Switching to SAP Cloud Identity Services - Identity Authentication](https://help.sap.com/docs/build-work-zone-standard-edition/sap-build-work-zone-standard-edition/switching-to-sap-cloud-identity-services-identity-authentication).

## Nest Steps

You are now ready to implement Authorization Management service in your application: [Integrate with Authorization Management service](./2-integrate-with-ams.md).

   
