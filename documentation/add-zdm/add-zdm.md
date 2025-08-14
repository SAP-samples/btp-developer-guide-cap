# Zero Downtime Maintenance 

Zero downtime maintenance is the process of updating your application without affecting its availability or performance. It means that your users can access your application at any time, even when you are deploying new features, bug fixes, or security patches.

If an application has goal of 99.99% availability, it may be unavailable for only 30 * 24 * 0.001 = **1.12 hours per month**. Longer downtimes entitle customers to financial compensation or even canceling the contract.

## Why Is Zero Downtime Maintenance So Important for Cloud Software-as-a-Service (SaaS) Solutions?

These are some of the benefits of keeping zero downtime maintenance for your application:
- **Business continuity and user experience**: SaaS applications are often mission-critical for businesses, any downtime can disrupt operations and lead to lost revenue. Zero downtime maintenance ensures continuous availability, minimizing disruptions and keeping users productive.
- **Customer satisfaction**: In today's competitive landscape, user experience is paramount. Downtime creates frustration and reflects poorly on the service. By maintaining smooth operation, SaaS providers build trust and user loyalty.
- **Subscription model reliance**: SaaS relies on recurring subscriptions. Downtime directly translates to lost service time for which users are paying. Zero downtime maintenance upholds the value proposition of the service and justifies subscription fees.
- **Competitive advantage**: In a crowded SaaS market, providers offering uninterrupted service gain a significant edge. Zero downtime maintenance demonstrates a commitment to reliability and a superior product, attracting and retaining customers.
- **Operational efficiency**: While it requires upfront investment, zero downtime maintenance can improve operational efficiency in the long run. By avoiding downtime-related issues like customer support surges and revenue loss, providers can focus on core business activities.

## Blue-Green Deployment of Multitarget Applications

By using the Blue-Green deployment strategy, you can update the application without downtime and with reduced risk. During deployent, you can perform tests and validation of the new application version using productive data. A classical Blue-Green deployment of stateless applications, which are modeled as an MTA, is supported. See [Best Practices from Indurstry Solutions](https://help.sap.com/docs/btp/sap-business-technology-platform/blue-green-deployment-of-multitarget-applications?q=zero%20downtime).

## Rolling Update (Applicable for SAP BTP, Kyma Runtime)

Users expect applications to be available all the time, and developers are expected to deploy new versions of these application several times a day. In Kubernetes, this is done using rolling updates. A rolling update allows the application to be deployed with zero downtime. It does this by incrementally replacing the current Pods with new ones. The new Pods are scheduled on Nodes with available resources. Kubernetes waits for those new Pods to start before removing the old Pods. See [Kubernetes documentation: Performing a Rolling Update](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/).

**SAP BTP, Kyma Runtime Supports Rolling Updates By Default**
<img src="./images/module_06_rollingupdates3.svg" height="600px" width="400px">
> Image credits: https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/

## Implementing Zero Downtime Maintenance 
Zero downtime maintenance can be implemented at different parts of the application in different patterns. The following table showcases different implementations to achieve zero downtime maintenance.

>
>**This table showcases components with standalone approuter-based application deployed to the SAP BTP, Cloud Foundry runtime**
> 
| Component | Pattern | Description |
|-----------|-----------|-----------|
| Approuter | [Redis](https://www.npmjs.com/package/@sap/approuter#external-session-management)     | Redis-based custom implementation for session management.|
| CAP Backend| [Blue-Green Strategy](https://help.sap.com/docs/btp/sap-business-technology-platform/blue-green-deployment-strategy?q=zero%20downtime): Applicable for SAP BTP, Cloud Foundry runtime|Blue-Green deployment is a technique that reduces downtime and risk by running two identical productive environments called Blue and Green. | 
|Database|Deploy only compatible database schema changes| Data base changes without breaking the current schema.|
|Front End Updates|Avoid breaking changes|Be aware that the content in the HTML5 repository does NOT enable Blue-Green deployment and is updated at the beginning of an MTA deployment before the Blue-Green deployment of the backend starts. This means that the new UI content is active during an MTA deployment when still the old and the new color is active. Therefore, the new UI code needs to be able to work with the old version of the OData service in the backend and the new version! Only when the Blue-Green deployment is finished and the routes are adapted to the new color, you can be sure that all ODAta requests are processed by the new OData version.|
|Service Updates (SAP Authorization and Trust Management service, SaaS Registry, and so on)|Compatible changes| Push small non braking changes to services to avoid any distruption. Always use live URLs when refering to backend or approuter URL in any services. |

## Managing Maintenance with Zero Downtime for Various Application Components

Let's look at the zero downtime maintenance from the perspective of the following components: backend, user interface and persistence:

- **[Code Changes](./code-zdm.md)**
- **[Persistance Changes](./persistance-zdm.md)**
- **[Content Changes](content-zdm.md)**

