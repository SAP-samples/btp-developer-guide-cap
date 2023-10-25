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

- You have completed the Development and Deployment of Basic CAP application. This can be done in two different ways:
    - By executing the Basic tutorial.
    - [Execute the preliminary setup.](https://github.tools.sap/refapps/incidents-mgmt/blob/main/documentation/prerequisite-for-sample/prerquites-for-sample.md)
- [Undeploy the application which was deployed to SAP BTP in previous steps.](https://github.tools.sap/refapps/incidents-mgmt/blob/main/documentation/prerequisite-for-sample/prerquites-for-sample.md#undeploy-the-application)

## Entitlements required
### Additional Entitlements Required

Remote Service Integration to the developed CAP application requires the following additional [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US) in the SAP BTP cockpit:

| Service                           | Plan       | Number of Instances |
|-----------------------------------|------------|:-------------------:|
| SAP Audit Log Service | premium | 1 |
| Audit Log Viewer Service | free/default | 1


   

