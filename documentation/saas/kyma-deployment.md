# Deploy in the SAP BTP, Kyma Runtime

## Prerequisites
- [Prepare for Kyma Development](./4-prepare-for-kyma.md)
  
## Deploy the Application

To deploy the application, use the following command:

```sh
helm upgrade --install <deployment-name> --namespace <namespace> ./gen/chart \
--set-file xsuaa.jsonParameters=xs-security.json
```
[Read more about Namespaces](https://kyma-project.io/#/api-gateway/user/tutorials/01-40-expose-workload/01-42-expose-workloads-multiple-namespaces?id=expose-workloads-in-multiple-namespaces-with-a-single-apirule-definition)

## Next Step

[Subscribe to the Multitenant Application](./5-subscribe.md)
