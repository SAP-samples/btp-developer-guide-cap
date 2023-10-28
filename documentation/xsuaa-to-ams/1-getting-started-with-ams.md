# Introduction

## About Authorization Management Service

The Authorization Management of SAP Cloud Identity Services provides libraries and services for developers of cloud business applications to declare, enforce and manage instance based authorization checks. Authorizations are declared as code-based "Policies" in the project of the cloud business application, assigned to users and enforced with client libraries for Node.js and Java.

## Prerequisites

1. Develop a basic full-stack CAP application. You have the following options:
    - **Option 1**: Go through the following group of tutorials based on the Incident Management application step by step and explore the source code. See [Develop a Full-Stack CAP Application](https://developers.sap.com/group.cap-application-full-stack.html).
    - **Option 2**: Go to the Incident Management application GitHub repository directly and download the application without going through the application development steps. See [Incident Management](https://github.com/cap-js/incidents-app).
        1. Run the following command to clone the Incident Management application:

            ```sh
            git clone https://github.com/cap-js/incidents-app.git
            ```
        2. Rename the root folder of the project to **Incident-Management**.
        3. Navigate to the **package.json** file from the project's root folder and change the  value of the **name** field to **incident-management**.

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

   
