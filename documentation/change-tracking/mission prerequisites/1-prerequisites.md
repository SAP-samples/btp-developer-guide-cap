# Prerequisites

1. Develop the Incident Management application following the step-by-step tutorial [Develop a Full-Stack CAP Application](https://developers.sap.com/group.cap-application-full-stack.html).

2. Deploy the Incident Management application to one of the following runtimes:
   - Option 1: Cloud Foundry runtime: [Deploy a Full-Stack CAP Application in Cloud Foundry Runtime](https://developers.sap.com/group.deploy-full-stack-cap-application.html).
    
   - Option 2: Kyma runtime: [Deploy a Full-Stack CAP Application in Kyma Runtime](https://developers.sap.com/group.deploy-full-stack-cap-kyma-runtime.html).

3. Undeploy your application by running the following command:
   
   - For Cloud Foundry runtime: `cf undeploy <YOUR_MTA_ID> --delete-services`
   - For Kyma runtime: `helm uninstall <RELEASE_NAME> -n <YOUR_NAMESPACE>`
