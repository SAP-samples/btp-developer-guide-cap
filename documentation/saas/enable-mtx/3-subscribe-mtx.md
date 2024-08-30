# Subscribe Tenants to the Application Locally

1. Subscribe to the first tenant locally by using the following command:

  ```shell
  cds subscribe t1 --to http://localhost:4005 -u yves:
  ```
  
  The output should look like this:

  ```shell
  Subscribing { tenant: 't1' } to { url: 'http://localhost:4005' }
  Subscribe successful.
  ```
  
2. Subscribe to the second tenant locally:

  ```shell
  cds subscribe t2 --to http://localhost:4005 -u yves:
  ```
  
The output should be:
```shell
Subscribing { tenant: 't2' } to { url: 'http://localhost:4005' }
Subscribe successful.
```

In response to each subscription, the sidecar creates a new persistent tenant database per tenant, keeping the tenant data isolated:

```shell
[rest] - POST /-/cds/deployment/subscribe 
[mtx] - (re-)deploying SQLite database for tenant: t1
  > init from db/data/sap.capire.incidents-Urgency.csv 
  > init from db/data/sap.capire.incidents-Status.csv 
  > init from db/data/sap.capire.incidents-Incidents.csv 
  > init from db/data/sap.capire.incidents-Incidents.conversation.csv 
  > init from db/data/sap.capire.incidents-Customers.csv 
/> successfully deployed to db-t1.sqlite 

[mtx] - subscribed tenant t1

```
> [!NOTE]   
> When running these commands, you use the predefined mocked user `yves`. For more information, see the section on [predefined mock users](https://cap.cloud.sap/docs/node.js/authentication#mock-users).
To see all available options, run `cds subscribe --help`.
