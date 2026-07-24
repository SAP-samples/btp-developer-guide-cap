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
cds up -2 k8s --namespace <namespace>
```

> Replace `<namespace>` with your Kyma namespace.

[Read more about Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)

## Next Step

[Subscribe to the Multitenant Application](./7-subscribe.md)
