# Deploy in the SAP BTP, Cloud Foundry Runtime

Build and deploy the MTA file with the following command:

> [!Warning]
> The Org name and Space name which make up the domain should not exceed 63 characters else after deployment, users will not be able to access the app. To handle this, ensure you are providing shorter Space, Org and subaccount names.

```sh
mbt build -t ./
cf deploy incident-management_1.0.0.mtar
```

> [!NOTE]
> When deploying an existing application with active users, it's recommended to use the Blue-Green Deployment strategy to minimize or eliminate downtime and ensure a seamless user experience.
>
> To implement the Blue-Green Deployment approach for Multitarget Applications (MTA), refer to the resources below:
> - [Blue-Green Deployment Strategy](https://help.sap.com/docs/btp/sap-business-technology-platform/blue-green-deployment-strategy)
> - [Documentation on Legacy Blue-Green Deployment](https://github.com/SAP-samples/cf-mta-examples/blob/main/blue-green-deploy-legacy/README.adoc)


## Next Step
[Subscribe to the Multitenant Application](./5-subscribe.md)

