## Set Up Data Collection for SAP Cloud ALM in a CAP Application

### Prerequisites
1. Depending on the runtime you want to deploy, choose one of the following options:
   - [You have deployed the application with SAP Cloud Logging to Cloud Foundry Runtime](./4-deploy-to-cf.md)
   <!-- - [You have deployed application with SAP Cloud Logging to Kyma Runtime](./enablements-kyma.md) -->
2. Open the application in VS code as in Business Application Studio that you will not be able to install some of the dependencies.  

**Exception monitoring for Incident Management will follow soon.** For guidance on implementing this in your application, please refer to the [Expert Portal.](https://support.sap.com/en/alm/sap-cloud-alm/operations/expert-portal/integration-monitoring.html)

## Enable Data Collection for Real User Monitoring and Health Monitoring
To enable data collection, you need to add the following configuration to your application:
1. Specify the credentials for the RBSC repository containing the OTEL ALM Libraries in an environment variable:
   - SAP_NPM_AUTH=<base64 encoded version of username:password>
     You can copy the NPM Base64 Credentials directly from the RBSC UI. The value for the environment variable is the Base64 encoding of the combination of 'username:password' where the user name is the user name of the technical user. Respectively, the same holds for password.

2. Create a `.npmrc` file at the root of the Incident Management application and paste the following: 
    ```sh
    //73555000100200018064.npmsrv.cdn.repositories.cloud.sap/:_auth=${SAP_NPM_AUTH}
    ```

   > [!NOTE] 
   > It is recommended to store the password in a vault and reference it in the settings, so that it can be read during build and pipeline deployment!
   >     



3. Paste the following code snippet in the **server.js** file after the `const counter = meter.createUpDownCounter('incidents.urgency.high');` line:
   ```js
    require('@sap/xotel-agent-ext-js/dist/common/tracer');
    const app = require('express')()
    const fesr = require("@sap/fesr-to-otel-js");
    cds.serve('all').in(app)
    app.listen()
    cds.on("bootstrap", (app) => fesr.registerFesrEndpoint(app));
   ```
4. In the terminal, run the following command to install dependencies:
   ```sh
    npm install @opentelemetry/api  @opentelemetry/exporter-logs-otlp-grpc cf-nodejs-logging-support hdb
   ```
   > Please refer [Here](https://help.sap.com/whats-new/aaa5ccb1a72444d5b54e2985250fab03?locale=en-US) for Data Collection Instrumentation Libraries

5. In the **package.json** manually add the following two dependencies:

   ```json
    "@sap/xotel-agent-ext-js": "//73555000100200018064.npmsrv.cdn.repositories.cloud.sap/@sap/xotel-agent-ext-js/-/xotel-agent-ext-js-1.5.22.tgz",
    "@sap/fesr-to-otel-js": "//73555000100200018064.npmsrv.cdn.repositories.cloud.sap/@sap/fesr-to-otel-js/-/fesr-to-otel-js-1.5.13.tgz"
   ```
    > Please ensure to use the latest library version, details can be found on [SAP Cloud ALM for Operations Expert Portal](https://support.sap.com/en/alm/sap-cloud-alm/operations/expert-portal/data-collection-infrastructure.html?anchorId=section_415688568)

6. In the **mta.yaml** file, add the following properties and resource to the current code:
   ```yaml
   ...
      - name: incidents-srv
        type: nodejs
        path: gen/srv
        properties:
          SAP_CALM_FESR_LOG_LEVEL: debug
          SAP_CALM_DCI_LOG_LEVEL: debug
          SAP_CALM_SERVICE_NAME: incidents-srv
          SAP_CALM_SERVICE_TYPE: SAP_CP_CF
          OTEL_RESOURCE_ATTRIBUTES: sap.tenancy.tenant_id=<tenant-id-of-your-subaccount> 
          NODE_ARGS: -r @sap/xotel-agent-ext-js/dist/common/tracer
    ...
        requires:
          - name: incident-management-db
          - name: incident-management-auth
          - name: incidents-cloud-logging 
          - name: incident-management-destination-service 
    ...
  
   ```
>[!NOTE] These properties can be updated from the BTP cockpit using application environment variables. 

7. Replace the `<tenant-id-of-your-subaccount>` with the tenant/sub-account ID of the account where you are deploying the application. 


8. Open **app/incidents/webapp/Component.js**. To collect front-end requests from the launchpad, add the following code line. Replace "ns.incidents.Component" with your application's name.
   ```js
   sap.ui.define(
	 ["sap/fe/core/AppComponent", "sap/ui/performance/trace/FESR"], function(Component, FESR) {
	     "use strict";
	  FESR.setActive(true, new URI(sap.ui.require.toURL("ns.incidents")).path() + "/fesr");
	     return Component.extend("ns.incidents.Component", {
		 metadata: {
		     manifest: "json"
		 }
	     });
	 }
	);
   ```
>[!NOTE] Disclaimer: This is considered a workaround and can be subject to change at any time.   
   
9. Open **app/incidents/webapp/xsapp.json** and add the following:
   ```json
   {
    "authenticationMethod": "route",
    "logout": {
      "logoutEndpoint": "/do/logout"
    },
    "routes": [
      ...
      {
        "source": "^/fesr$", 
        "target": "/fesr", 
        "destination": "srv-api", 
        "csrfProtection": false, 
        "authenticationType": "none" 
      }, 
         ....
      ]
      }
   ```
>[!NOTE] Step 6-8 are optional, these are required for UI applications only. If you are not having any UI, these steps can be skipped. 

10. Open **package.json** at the root of the application and replace the start command:
      ```json
         "scripts":{
            "start": "node ${NODE_ARGS} ./node_modules/@sap/cds/bin/serve",
         }
      ```
      > NOTE: The above configuration is supported for cds 8 and above. For lower versions you can use `cds-serve`.
11. Go to root of the application and run `mbt build` to build the application. 
   > [!TIP]
   >If the build is failing, delete the **node_modules, package-lock.json**, install the node_modules and try building the application again.
   >Also, the build might take longer than usual due to the additional dependencies.

12. Run `cf deploy mta_archives/incident-management_1.0.0.mtar` to deploy the application. 
  

With these steps, you have prepared the data collection for SAP Cloud ALM. Process with next chapter. 

## Next Steps
[Setup SAP Cloud ALM](./configure-sap-cloud-alm.md)
