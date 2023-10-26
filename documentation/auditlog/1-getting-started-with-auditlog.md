# Introduction

Audit logs are a special type of logs. They represent security-relevant chronological records that provide documentary evidence for an event or activity. The SAP Audit Log service only stores audit logs written by SAP BTP services, when you take action over your account data.

## SAP Auditlog Service

The SAP Audit Log service stores audit logs representing different actions taken over your account and/or data. There are predefined audit categories, which represent such kinds of actions:
- Data protection and privacy related
    - **audit.data-access:** read-access logging records for access to sensitive personal data;

    - **audit.data-modification:** data modification logging records for sensitive personal data.

- Security related
    - **audit.security-events:** logging of general security events like login, logout, and others.

    - **audit.configuration:** logging of security critical configuration changes.

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
   - For SAP BTP, Cloud Foundry runtime:
     1. [Prepare for SAP BTP Development with Cloud Foundry Runtime](https://developers.sap.com/tutorials/prepare-btp-cf.html).
     2. Follow until [Add the UI Applicaiton](https://developers.sap.com/tutorials/deploy-to-cf.html#2d5dd378-1a41-4166-9a4b-75f8181ba71f) in [Deploy in SAP BTP, Cloud Foundry Runtime](https://developers.sap.com/tutorials/deploy-to-cf.html#2d5dd378-1a41-4166-9a4b-75f8181ba71f)
   - For SAP BTP, Kyma runtime:
     1. [Prepare for Deployment and Deploy in SAP BTP, Kyma Runtime](../prerequisite-for-sample/prerquites-for-sample.md#prepare-application-to-deploy-to-kymak8s).

3. (Optional) If you have deployed this application, undeploy your application by running the following command:
   
   - For SAP BTP, Cloud Foundry runtime: `cf undeploy <YOUR_MTA_ID> --delete-services`
    - For SAP BTP, Kyma runtime: `helm uninstall <RELEASE_NAME> -n <YOUR_NAMESPACE>`

## Entitlements required
### Additional Entitlements Required

Remote Service Integration to the developed CAP application requires the following additional [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US) in the SAP BTP cockpit:

| Service                           | Plan       | Number of Instances |
|-----------------------------------|------------|:-------------------:|
| SAP Audit Log Service | premium | 1 |
| Audit Log Viewer Service | free/default | 1


   

