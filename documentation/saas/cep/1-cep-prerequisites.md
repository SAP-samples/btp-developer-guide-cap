## SAP Build WorkZone Central Entry Point Based Multitenancy
The SAP Build Work Zone Central Entry point approach will look like the following:
<img src="./images/SaaS-CEP-SolutionDiagram.png"/>

## Additional Entitlements Required 

| Service                                    | Plan       | Number of Instances |
|--------------------------------------------|------------|:-------------------:|
| Service Manager                            | container       |          1          |
| SAP Software-as-a-Service Provisioning service | application |          1          |

## Prerequisites

1. Have the Incident Management application deployed in one of the following SAP BTP runtimes:
> Please follow the steps of **Integrate your application with SAP Build Work Zone, standard edition using Common Data Model**

   - Option 1: SAP BTP, Cloud Foundry runtime: [Deploy a Full-Stack CAP Application in SAP BTP, Cloud Foundry Runtime](https://developers.sap.com/group.deploy-full-stack-cap-application.html).
    
   - Option 2: SAP BTP, Kyma runtime:  [Deploy a Full-Stack CAP Application in SAP BTP, Kyma Runtime](https://developers.sap.com/group.deploy-full-stack-cap-kyma-runtime.html).


2. **Enable Multitenancy** by following the steps in:
   [Enable multitenancy for the CAP application](https://discovery-center.cloud.sap/protected/index.html#/mymissiondetail/210866/cardName/Enable%20multitenancy%20for%20the%20CAP%20application/?tab=projectboard)


> **Note:** To clean up settings before continuing with this scenario, you can undeploy the Incident Management application:
> - For SAP BTP, Cloud Foundry runtime: `cf undeploy <YOUR_MTA_ID> --delete-services`
> - For SAP BTP, Kyma runtime: `helm uninstall <RELEASE_NAME> -n <YOUR_NAMESPACE>`

