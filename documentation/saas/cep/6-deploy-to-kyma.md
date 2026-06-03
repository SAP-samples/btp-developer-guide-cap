# Deploy in the SAP BTP, Kyma Runtime

## Prerequisites
- [Prepare for Kyma Development](./5-prepare-for-kyma.md)
  
## Deploy the Application
To deploy the application we need to update the gen/chart folder with the new configurations added in the chart/values.yaml file.
Run the following command:

```sh
cds build --production
```

To deploy the application, use the following command:

```sh
helm upgrade --install <deployment-name> --namespace <namespace> ./gen/chart \
--set-file xsuaa.jsonParameters=xs-security.json
```

> Replace `<deployment-name>` with your Helm release name and `<namespace>` with your Kyma namespace.

[Read more about Namespaces](https://kyma-project.io/#/api-gateway/user/tutorials/01-40-expose-workload/01-42-expose-workloads-multiple-namespaces?id=expose-workloads-in-multiple-namespaces-with-a-single-apirule-definition)

## Next Step

[Subscribe to the Multitenant Application](./7-subscribe.md)
