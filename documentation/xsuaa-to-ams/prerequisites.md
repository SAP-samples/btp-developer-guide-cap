# Make Sure That Prerequisites Are Fulfilled and All Required Systems Are in Place

## Prerequisites

1. Develop the Incident Management application following the step-by-step tutorial [Develop a Full-Stack CAP Application](https://developers.sap.com/group.cap-application-full-stack.html).
   
## Systems and Entitlements Required

 - *[For local testing only]* To use the Authorization Management service, you must have `Java 11+` or a later version installed on your system.
     
 - Authorization Management service integration to the developed CAP application requires the following additional entitlements and quotas in the SAP BTP cockpit:

    | Service                           | Plan       | Number of Instances |
    |-----------------------------------|------------| :-------------------:|
    | Cloud Identity Service | application | 1 |

   See [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US).
   
 - Establish an Identity Authentication trust. In your SAP BTP subaccount where the applications that will use the Authorization Management service resides, establish trust to your SAP Identity Authentication tenant.
   
 - The SAP Build Workzone has Identity Authentication enabled. See [Switching to SAP Cloud Identity Services - Identity Authentication](https://help.sap.com/docs/build-work-zone-standard-edition/sap-build-work-zone-standard-edition/switching-to-sap-cloud-identity-services-identity-authentication). For the recently created SAP Build Workzone tenants, the Identity Authentication is enabled by default.

   
