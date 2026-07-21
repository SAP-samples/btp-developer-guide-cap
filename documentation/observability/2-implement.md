
# Setup Custom Log Collection
Application logging is the practice of recording valuable information and events during software execution. Logs are persisted to retain a historical record of activities, errors, and user interactions. They are categorized into different log levels, such as DEBUG, INFO, WARN, ERROR, and FATAL, to signify their importance and severity.

Analysis, persistency of Logs is recommended in standardized, centralized and hosted service like SAP Cloud Logging.


## Prerequisites

You have the Incident Management application set up. See the [Develop a Full-Stack CAP Application Following SAP BTP Developer’s Guide](https://developers.sap.com/group.cap-application-full-stack.html) tutorial group.   

## Adding custom logs to the application

To add logs in the Incident Management application, take advantage of the minimalistic logging facade that CAP provides. To add logging functionality to the Incident Management application:

1. Open `srv/services.js`.

2. After the existing `const cds = require('@sap/cds')` line at the top of the file, add the logger initialization:

   ```javascript
   const cds = require('@sap/cds')
   const LOG = cds.log('processor-service')  // <-- add this line
   ```

3. In the `onUpdate` method, expand the single-line `if (closed)` statement into a block and add the log statement before `req.reject`:

   ```javascript
   async onUpdate (req) {
     let closed = await SELECT.one(1) .from (req.subject) .where `status.code = 'C'`
     if (closed) {                                                        // <-- expand to block
       LOG.info(`Incident ${req.data.ID} has already been closed`)       // <-- add this line
       req.reject `Can't modify a closed incident!`
     }
   }
   ```

For more information, see [Minimalistic Logging Facade by CAP](https://cap.cloud.sap/docs/node.js/cds-log#minimalistic-logging-facade).

## Defining Log Levels

Configure the initial log levels per module through `cds.log.levels`, for example like that in your `package.json`:
  
  ```json
  {
    "cds": {
    ...
      "log": {
        "levels": {
          "sqlite": "debug",
          "cds": "info"
        }
      }
    ...
    }
  }
  ```
## Run and Test Locally

Once the application has all the required configurations, you can test it locally. 

1. In the terminal, run the application with the `cds watch` command.
2. Open the application and create a incident. 
3. To view custom logs, try changing the urgency of a closed incident. You will see something like this in console: 
   
   ```
    [processor-service] - Incident 3b23bb4b-4ac7-4a24-ac02-aa10cabd842c has already been closed
   ```  
## Next Step  
[Setup Trace Collection](./3-implement-traces.md)
