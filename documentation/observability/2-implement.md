# Introduce Custom Metrics, Logs and Trace Spans to Capture Service-Specific Observability Telemetry 

We recommend that you add additional service-specific observability telemetry signals to the build-in general monitoring and observability signals emitted by the SAP Application Programing Model (CAP) framework. Service teams should introduce specific metrics, logs and trace spans. Building up own dashboards, user flow up to defining own alerting patterns on top of these customised signals can improve efficiency in problem and incident situation.

In this tutorial, you will learn how to create service-specific telemetry signals (logs, metrics and trace) for the Incident Management application.

## Prerequisites

You have the Incident Management application set up. See the [Develop a Full-Stack CAP Application Following SAP BTP Developer’s Guide](https://developers.sap.com/group.cap-application-full-stack.html) tutorial group.   

## Add Logs in the Application

To add logs in the Incident Management application, take advantage of the minimalistic logging facade that CAP provides. To add logging functionality to the Incident Management application:

1. Open `srv/processor-service.js`.
2. Add the following lines to you the code of the **srv/processor-service.js** file.
   
   ```javascript
     const cds = require('@sap/cds')
     const LOG = cds.log('processor-service');
   ```

3. To define logs as part of the custom logic, add the following lines to the code of the **srv/processor-service.js** file.
   
   ```javascript
    if (status_code === 'C'){
      LOG.info(`Incident ${req.data.ID} has already been closed`);
      return req.reject(`Can't modify a closed incident`)
     }
   ```
For more information, see [Minimalistic Logging Facade by CAP](https://cap.cloud.sap/docs/node.js/cds-log#minimalistic-logging-facade).

## Defining Log Levels

Configure the initial log levels per module through `cds.env.log.levels`, for example like that in your `package.json`:
  
  ```json
  {
    "cds": {
      "log": {
        "levels": {
          "sqlite": "debug",
          "cds": "info"
        }
      }
    }
  }
  ```
## Run and Test Locally

Once the application has all the requried configurations, you can test it locally. 

1. In the terminal, run the application with the `cds watch` command.
2. Open the application and create a incident. 
3. To view custom logs, try changing the urgency of a closed incident. You will see something like this in console: 
   
   ```
    [processor-service] - Incident 3b23bb4b-4ac7-4a24-ac02-aa10cabd842c has already been closed
   ```  
## Next Step  
[Setup Trace Collection](./3-implement-traces.md)
