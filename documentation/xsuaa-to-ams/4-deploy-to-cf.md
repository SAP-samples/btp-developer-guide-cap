# Deploy the Application to Cloud Foundry
In this section, you will deploy the Incident Management CAP application integrated with IAS and AMS to the SAP BTP Cloud Foundry runtime.

## Prerequisites
- You have completed the [Prepare for Production](./3-prepare-for-production.md) steps to configure your CAP application for production deployment.
- You have the [Cloud Foundry CLI](https://docs.cloudfoundry.org/cf-cli/install-go-cli.html) installed on your local machine.
- You have logged in to your SAP BTP Cloud Foundry subaccount using the Cloud Foundry CLI:

   ```shell
   cf login -a https://api.<region>.cf.<domain> --sso
   ```

   Replace `<region>` and `<domain>` with your specific region and domain details.

## Add MTA and Deploy to Cloud Foundry

1. Use `cds up` command to create the necessary MTA files for deployment:

   ```shell
   cds up
   ```

   This command will do the following:

   - Create a `mta.yaml` file in the root directory of your project.
   - Build the srv and UI modules and place the build artifacts.
   - Push the application to Cloud Foundry.

2. The `mta.yaml` file will look like this, the project name and module names will vary based on your project setup:

   <details>
   <summary>Click to view the complete mta.yaml file for reference</summary>

   ```yaml
   _schema-version: 3.3.0
   ID: incident-management
   version: 1.0.0
   description: "A simple CAP project."
   parameters:
     enable-parallel-deployments: true
     deploy_mode: html5-repo
   build-parameters:
     before-all:
       - builder: custom
         commands:
           - npm ci
           - npx cds build --production
   modules:
     - name: incident-management-srv
       type: nodejs
       path: gen/srv
       parameters:
         instances: 1
         buildpack: nodejs_buildpack
         routes:
           - route: "${default-url}"
           - route: "${default-host}.cert.${default-domain}"
       build-parameters:
         builder: npm-ci
       provides:
         - name: srv-api # required by consumers of CAP services (e.g. approuter)
           properties:
             srv-url: ${default-url}
             srv-cert-url: '${protocol}://${default-host}.cert.${default-domain}'
       requires:
         - name: incident-management-ias
           parameters:
             config:
               credential-type: X509_GENERATED
               app-identifier: srv
         - name: incident-management-db
         - name: incident-management-destination
       deployed-after:
         - incident-management-ams-policies-deployer
       properties:
         AMS_DCL_ROOT: ams/dcl

     - name: incident-management-ams-policies-deployer
       type: javascript.nodejs
       path: gen/policies
       parameters:
         buildpack: nodejs_buildpack
         no-route: true
         no-start: true
         tasks:
           - name: deploy-dcl
             command: npm start
             memory: 512M
       requires:
         - name: incident-management-ias
           parameters:
             config:
               credential-type: X509_GENERATED
               app-identifier: ams-policy-deployer

     - name: incident-management-db-deployer
       type: hdb
       path: gen/db
       parameters:
         buildpack: nodejs_buildpack
       requires:
         - name: incident-management-db

     - name: incident-management-app-deployer
       type: com.sap.application.content
       path: gen
       requires:
         - name: srv-api
         - name: incident-management-ias
           parameters:
             config:
               credential-type: X509_GENERATED
               app-identifier: app-deployer
         - name: incident-management-html5-repo-host
           parameters:
             content-target: true
             config:
               HTML5Runtime_enabled: true
               IASDependencyName: incident-management-ias-api
       build-parameters:
         build-result: app/
         requires:
           - name: incidentmanagementincidents
             artifacts:
               - incidents.zip
             target-path: app/

     - name: incidentmanagementincidents
       type: html5
       path: app/incidents
       build-parameters:
         build-result: dist
         builder: custom
         commands:
           - npm ci
           - npm run build
         supported-platforms:
           []

     - name: incident-management-destinations
       type: com.sap.application.content
       requires:
         - name: incident-management-html5-repo-host
           parameters:
             service-key:
               name: incident-management-html5-repo-host-key
         - name: srv-api
         - name: incident-management-destination
           parameters:
             content-target: true
       build-parameters:
         no-source: true
       parameters:
         content:
           instance:
             existing_destinations_policy: update
             destinations:
               - Name: incident-management-html5-repository
                 ServiceInstanceName: incident-management-html5-repo-host
                 ServiceKeyName: incident-management-html5-repo-host-key
                 sap.cloud.service: incidentmanagement.service

   resources:
     - name: incident-management-ias
       type: org.cloudfoundry.managed-service
       parameters:
         service: identity
         service-name: incident-management-ias
         service-plan: application
         config:
           provided-apis:
             - name: incident-management-ias-api
               description: API exposed by the application
           display-name: incident-management
           oauth2-configuration:
             token-policy:
               access-token-format: "jwt"
           authorization:
             enabled: true
           xsuaa-cross-consumption: true
     - name: incident-management-db
       type: com.sap.xs.hdi-container
       parameters:
         service: hana
         service-plan: hdi-shared
     - name: incident-management-destination
       type: org.cloudfoundry.managed-service
       parameters:
         service: destination
         service-plan: lite
         config:
           HTML5Runtime_enabled: true
           init_data:
             instance:
               existing_destinations_policy: update
               destinations:
                 - Name: srv-api
                   URL: ~{srv-api/srv-url}
                   Authentication: NoAuthentication
                   Type: HTTP
                   ProxyType: Internet
                   HTML5.ForwardAuthToken: true
                   HTML5.DynamicDestination: true
                   HTML5.IASDependencyName: 'incident-management-ias-api'
       requires:
         - name: srv-api
           group: destinations
           properties:
             name: srv-api # must be used in xs-app.json as well
             url: ~{srv-url}
             forwardAuthToken: true

     - name: incident-management-html5-repo-host
       type: org.cloudfoundry.managed-service
       parameters:
         service: html5-apps-repo
         service-plan: app-host
     - name: incident-management-html5-runtime
       type: org.cloudfoundry.managed-service
       parameters:
         service: html5-apps-repo
         service-plan: app-runtime
   ```

   </details>


## Troubleshooting Deployment and Access Issues

If there is a misconfiguration in the `mta.yaml` file, you might get errors when accessing the applications, Error code `503` or `401`. To resolve such issues, please follow these steps:

1. Review the `incident-management-app-deployer` module in the `mta.yaml` file to ensure that it correctly references the `incident-management-ias` services.

   ```yaml
   - name: incident-management-ias
     parameters:
       config:
         credential-type: X509_GENERATED
         app-identifier: app-deployer
   ```

2. The `IASDependencyName` parameter should match the name of the `provided-apis` defined in the `incident-management-ias` resource.

   ```yaml
   provided-apis:
     - name: incident-management-ias-api
   ```

3. The destination service must also have the property `HTML5.IASDependencyName` set to the same value.

   ```yaml
   destinations:
     - Name: srv-api
       URL: ~{srv-api/srv-url}
       Authentication: NoAuthentication
       Type: HTTP
       ProxyType: Internet
       HTML5.ForwardAuthToken: true
       HTML5.DynamicDestination: true
       HTML5.IASDependencyName: 'incident-management-ias-api'
   ```

