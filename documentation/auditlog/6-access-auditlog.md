### Accessing Audit Logs using SAP Audit Log Viewer service

1. The SAP Audit Log Viewer service displays the audit logs for your Cloud Foundry account, produced by SAP applications and services you’ve subscribed to.

    - see Audit Log Viewer for the Cloud Foundry Environment: https://help.sap.com/docs/btp/sap-business-technology-platform/audit-log-viewer-for-cloud-foundry-environment

2. To use the SAP Audit Log Viewer service, subscribe to it using the SAP BTP cockpit in the Services->Instances and Subscriptions-> Subscriptions tab of your subaccount.Choose `default` or `free` service plan.<br/>
 Once you're subscribed, select Go to Application to open the SAP Audit Log Viewer service and log in there.
3. To retrieve the audit logs for your subaccount using the SAP Audit Log Viewer service, you need to have proper authorizations.
    - Create a role-collection `auditlog viewer` by navigating to your subaccount-> Role Collections.![](./images/auditlog-rolecollection.png)
    - Add the following roles and save:![](./images/auditlog-roles.png)
    - Assign this role-collection to your user.
4. Now, Access the Audit Log Viewer Service and you will see the list of the auditlogs.
    - Filter out the logs by `data-access`, adjust the time range and you will see the similar logs entries:![](./images/auditlog-viewer.png)
