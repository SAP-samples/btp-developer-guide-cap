# Enable Observability in the SAP BTP, Cloud Foundry Runtime

## Deploy the Incident Management Application in the SAP BTP, Cloud Foundry Runtime

1. Assemble everything into a single `mta.tar` archive with the following command:

    ```
    mbt build
    ```
    See [Multitarget Applications in the Cloud Foundry Runtime](https://help.sap.com/docs/btp/sap-business-technology-platform/multitarget-applications-in-cloud-foundry-environment) to learn more about MTA-based deployment.


2. Make sure you're logged in to your subaccount:

    ```
    cf api <API-ENDPOINT>
    cf login -u <USER-ID> -p <PASSWORD>
    cf target -o <ORG> -s <SPACE>
    ```
    >Tip:
    >
    >You can find the API end point in the **Overview** section of your subaccount.
    >
    
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

To be able to access the application via the URL, you have to assign specific roles to the application. See [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html).

As a next step, to access the application in launchpad, proceed to [Integrate with SAP Build Workzone](https://developers.sap.com/tutorials/integrate-with-work-zone.html).

## Summary

The application has been deployed with custom logs, metrics and trace collection in the SAP BTP, Cloud Foundry runtime and integrated into SAP Build Work Zone.

# Visualize Logs, Metrics and Traces
- [Access custom logs, metrics, traces](./6-test-the-flow.md)
