# Enable Observability in the SAP BTP, Cloud Foundry Runtime

## Set Up the SAP Cloud Logging Service

To access and analyze observability telemetry signals in your SAP BTP, Cloud Foundry runtime, use the [SAP Cloud Logging](https://discovery-center.cloud.sap/serviceCatalog/cloud-logging) service. To configure the SAP Cloud Logging service, add cloud logging configuration under resources, bind it to the incident-management service in requires section. 

```yaml
      - name: incident-management
        type: nodejs
        path: gen/srv
        parameters:
        buildpack: nodejs_buildpack
        memory: 256MB
        build-parameters:
        builder: npm-ci
        provides:
        - name: srv-api # required by consumers of CAP services (e.g. approuter)
            properties:
            srv-url: ${default-url}
        requires:
        - name: incidents-auth
        - name: incidents-db
        - name: incidents-cloud-logging ## add cloud logging service instance

    ...
    resources:
    ...
     - name: incidents-cloud-logging  
       type: org.cloudfoundry.existing-service 
 ```

## Deploy the Incident Management Application in the SAP BTP, Cloud Foundry Runtime

1. Assemble everything into a single `mta.tar` archive with the following command:

    ```
    mbt build
    ```
    See [Multitarget Applications in the Cloud Foundry Runtime](https://help.sap.com/docs/btp/sap-business-technology-platform/multitarget-applications-in-cloud-foundry-environment) to learn more about MTA-based deployment.


2. Make sure you're logged in to your subaccount:

3. Navigate to the `mta_archives` folder and deploy the generated archive to the SAP BTP, Cloud Foundry runtime using the following command:

    ```
    cf deploy incident-management_1.0.0.mtar 
    ```

This process can take a couple of minutes and finally creates a log output like this:

```
[…]
Application "incident-management-srv" started and available at
"[org]-[space]-incident-management.[landscape-domain].com"
```


## Summary

The application has been deployed with custom logs, metrics and trace collection in the SAP BTP, Cloud Foundry runtime and integrated into SAP Build Work Zone.

# Visualize Logs, Metrics and Traces
- [Access custom logs, metrics, traces](./6-test-the-flow.md)
