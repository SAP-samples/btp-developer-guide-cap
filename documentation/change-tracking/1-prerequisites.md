# Prerequisites

1. Develop the Incident Management application following the step by step tutorial [Develop a Full-Stack CAP Application](https://developers.sap.com/group.cap-application-full-stack.html).

2. Deployed the Incident Management application, to one of the following BTP runtime:
   - Option 1: SAP BTP, Cloud Foundry runtime: [Deploy a Full-Stack CAP Application in SAP BTP, Cloud Foundry Runtime](https://developers.sap.com/group.deploy-full-stack-cap-application.html).
    
   - Option 2: SAP BTP, Kyma runtime:  [Deploy a Full-Stack CAP Application in SAP BTP, Kyma Runtime](https://developers.sap.com/group.deploy-full-stack-cap-kyma-runtime.html).

3. Undeploy your application by running the following command:
   
   - For SAP BTP, Cloud Foundry runtime: `cf undeploy <YOUR_MTA_ID> --delete-services`
   - For SAP BTP, Kyma runtime: `helm uninstall <RELEASE_NAME> -n <YOUR_NAMESPACE>`
