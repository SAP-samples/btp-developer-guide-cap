
## Setup  Metrics collection
Metrics are "measurements captured at runtime", which help you understand your app's health and performance.

Out of the box, `@cap-js/telemetry` offers metrics regarding the app's database pool, namely the [pool info](https://www.npmjs.com/package/generic-pool#pool-info) statistics of `generic-pool`.

## Run and test locally
Once the application has all the requried configurations. The application can be tested locally. 

1. In the terminal run the application with `cds watch`
2. Open the application and create a incident. 
3. Check the logs in terminal

    Example db pool metrics printed to the console:
    ```
    [telemetry] - db.pool:
        size | available | pending
          1/1 |       1/1 |       0
    ```

## Adding custom metrics to the application

The business user could check how many "**High**" incidents are being currently handled in the system using the custom metrics.
Custom metrics can be added as shown in the following example:

1. Create a new file at root of the application, name it `server.js` and paste the following code:
   ```js
    const cds = require('@sap/cds')
    // Import necessary modules
    const { metrics } = require('@opentelemetry/api');

    const meter = metrics.getMeter('@capire/incidents:incidents.urgency.high');
    // Create a counter
    const counter = meter.createUpDownCounter('incidents.urgency.high');

    cds.on('served', async () => {
    const { ProcessorService } = cds.services
    // Increase count when new incident with high urgency is created
    ProcessorService.after("CREATE", "Incidents", (results, req) => {
        if (results.urgency_code === "H" && results.status_code !== "C") {
        counter.add(1, { 'sap.tenancy.tenant_id': req.tenant });
        }
    });
    // Reduce count once incident is closed
    ProcessorService.after("UPDATE", "Incidents", (results, req) => {
        if (results.urgency_code === "H" && results?.status_code === "C") {
        counter.add(-1, { 'sap.tenancy.tenant_id': req.tenant });
        }
    });
    });
    module.exports = cds.server
   ```
  

## Deploy the application
- For BTP Cloud Foundry runtime, follow the steps described [here](./4-deploy-to-cf.md) 
- For BTP Kyma runtime, follow the steps described [here](./5-deploy-to-kyma.md)
