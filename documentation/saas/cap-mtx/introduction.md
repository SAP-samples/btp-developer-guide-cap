## What Is Multitenancy?
SAP BTP provides a multitenant functionality that allows application providers to own, deploy, and operate tenant-aware applications for multiple consumers, with reduced costs. For example, the application provider upgrades the application for all your consumers instead of performing each update individually, or share resources across multiple consumers. The application consumers launch the applications using consumer-specific URLs, and configure certain application features.

With tenant-aware applications, you can:
- Separate data securely for each tenant
- Save resources by sharing them among tenants
- Update applications efficiently, in a single step

Multitenancy can be visualized as follows:


<img src="../images/multitenancyblockdiagran.png"/>


For more information, see [Developing Multitenant Applications](https://help.sap.com/docs/btp/sap-business-technology-platform/developing-multitenant-applications-in-cloud-foundry-environment?locale=en-US).

**Provider Subaccount**
A provider subaccount is the central account where the multitenant application is deployed and managed. This subaccount is responsible for:

- Hosting the Multitenant Application: The application is deployed to this subaccount.
- Managing Lifecycle and Resources: Centralized management of the application lifecycle and resources.
- Creating and Managing Tenant Subaccounts: Setting up subaccounts for each consumer.
- Setting Up Role Access Authorizations: Configuring necessary roles and permissions.
- Deploying Across Regions: If needed, deploying the application to provider subaccounts in multiple regions.

**Subscriber Subaccount**
A subscriber subaccount is an account created for each consumer (tenant) that subscribes to the multitenant application. This subaccount is responsible for:

- Accessing the Application: Consumers access the application through a dedicated URL.
- Subscription Management: Consumers subscribe to the provider application from their subaccount.
- Read Access to Audit Logs: Consumers have read access to their own audit logs.



CAP has built-in support for multitenancy with the [@sap/cds-mtxs package.](https://www.npmjs.com/package/@sap/cds-mtxs)

Essentially, multitenancy is the ability to serve multiple tenants through single clusters of microservice instances, while strictly isolating the tenants' data. Tenants are clients using SaaS solutions.

In contrast to single-tenant mode, applications don't serve user request immediately after deployment, but wait for tenants to subscribe.

## Solution Diagram

<image src="./common-saas.png"/>

The above diagram shows the solution diagram for a multi-tenant application. One thing to note is that both the provider and subscriber subaccounts should be part of the same data center or region. 

