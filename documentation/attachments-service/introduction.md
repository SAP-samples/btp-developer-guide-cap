# Introduction
The [@cap-js/attachments](https://github.com/cap-js/attachments) package is a CDS plugin that provides out-of-the box asset storage and handling. To use it, extend a domain model by using the predefined aspect called Attachments. It also provides a CAP-level, easy to use integration of the SAP Object Store.

# Business Scenario

The Attachments Service in our Incident Management Application streamlines the storage and management of files related to incidents. Integrated with the SAP Object Store Service, it ensures secure, efficient, and scalable storage for incident documentation. Users can seamlessly upload, access, and manage files within the application, enhancing productivity and workflow efficiency. With features like secure storage, efficient retrieval, version control, and seamless integration, the Attachments Service simplifies the incident management process, enabling users to document and resolve incidents effectively.

To follow along with this guide, Complete the prerequisites and ensure that all the required systems are in place.

# Prerequisites
1. Develop the Incident Management application following the step-by-step tutorial [Develop a Full-Stack CAP Application](https://developers.sap.com/group.cap-application-full-stack.html).

2. Deploy the Incident Management application to Cloud Foundry runtime:
   - SAP BTP, Cloud Foundry runtime: [Deploy a Full-Stack CAP Application in SAP BTP, Cloud Foundry Runtime](https://developers.sap.com/group.deploy-full-stack-cap-application.html).

3. Undeploy your application by running the following command:
   
   - For SAP BTP, Cloud Foundry runtime: `cf undeploy <YOUR_MTA_ID> --delete-services`

# Required Additional Entitlements

To use attachments, enable the following additional entitlements and quotas in the SAP BTP cockpit:

| Service                           | Plan       | Number of Instances |
|-----------------------------------|------------|:-------------------:|
| Object Store| s3-standard | 1 |
| SAP Malware Scanning Service | clamav | 1 |


See [Entitlements and Quotas](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/00aa2c23479d42568b18882b1ca90d79.html?locale=en-US).

## Next Steps
- [Add attachments service](./extend-app.md)