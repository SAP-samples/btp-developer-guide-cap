# Prerequisites

1. Develop a basic full-stack CAP application by following the below group of tutorials based on the Incident Management application step by step and explore the source code. See [Develop a Full-Stack CAP Application](https://developers.sap.com/group.cap-application-full-stack.html).

2. (Optional) If you have not deployed this application, do the following:
   - For SAP BTP, Cloud Foundry runtime:
     1. [Prepare for SAP BTP Development with Cloud Foundry Runtime](https://developers.sap.com/tutorials/prepare-btp-cf.html).
     2. Follow until [Add the UI Applicaiton](https://developers.sap.com/tutorials/deploy-to-cf.html#2d5dd378-1a41-4166-9a4b-75f8181ba71f) in [Deploy in SAP BTP, Cloud Foundry Runtime](https://developers.sap.com/tutorials/deploy-to-cf.html#2d5dd378-1a41-4166-9a4b-75f8181ba71f)
   - For SAP BTP, Kyma runtime:
     1. [Prepare for Deployment and Deploy in SAP BTP, Kyma Runtime](../prerequisite-for-sample/prerquites-for-sample.md#prepare-application-to-deploy-to-kymak8s).

3. (Optional) If you have deployed this application, undeploy your application by running the following command:
   
   - For SAP BTP, Cloud Foundry runtime: `cf undeploy <YOUR_MTA_ID> --delete-services`
    - For SAP BTP, Kyma runtime: `helm uninstall <RELEASE_NAME> -n <YOUR_NAMESPACE>`
