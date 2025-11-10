# Deploy the Application to Kyma Runtime

In this section, you will deploy the Incident Management CAP application integrated with IAS and AMS to the SAP BTP Kyma runtime.

## Prerequisites

- You have completed the [Prepare for Production](./3-prepare-for-production.md) steps to configure your CAP application for production deployment.
- You have [enabled the Kyma runtime in your SAP BTP subaccount](https://developers.sap.com/tutorials/prepare-btp-kyma.html)
- You have installed `kubectl` and `docker` or any other container management tools on your local machine.
- Install `ctz` cli using `npm i -g ctz` command.

## Add Helm Charts and Deploy to Kyma Runtime

### Prerequisites for Kyma Deployment

- Ensure that you have access to a container registry (like Docker Hub or SAP Container Registry) to push your container images.
- Make sure you have logged in to your SAP BTP Kyma runtime on your local machine.

1. Use `cds up` command to create the necessary MTA files for deployment:

   ```shell
   cds up --to k8s --namespace <your-namespace>
   ```

   > [!TIP] 
   > The command will ask to enter the container registry details to push the images. Enter the required details.
   > If the deployment fails, you can manually check the `values.yaml` file inside the `chart` folder and modify the configurations as needed. We will have troubleshooting steps at the end of this section.

   This command will do the following:

   - Create `helm charts` inside `chart` folder your project.
   - Create a `containerize.yaml` file in the root directory of your project.
   - Build Necessary container images for srv, ams deployer and UI modules.
   - Deploy the application to Kyma Runtime.

2. The `chart/values.yaml` file will look like this, the project name and module names will vary based on your project setup:

   <details>
   <summary>Click to view the complete values.yaml file for reference</summary>

   ```yaml
   # yaml-language-server: $schema=./values.schema.json

   global:
     domain: <your-domain>
     imagePullSecret:
       name: docker-registry
     image:
       registry: <your-registry>
       tag: latest

   srv:
     bindings:
       auth:
         serviceInstanceName: identity
         parameters:
           credential-type: X509_GENERATED
           app-identifier: srv
       db:
         serviceInstanceName: hana
       destination:
         serviceInstanceName: destination
     image:
       repository: incident-management-srv
     resources:
       limits:
         ephemeral-storage: 1G
         memory: 500M
       requests:
         ephemeral-storage: 1G
         cpu: 500m
         memory: 500M
     health:
       liveness:
         path: /health
       readiness:
         path: /health
     env:
       AMS_DCL_ROOT: ams/dcl

   identity:
     serviceOfferingName: identity
     servicePlanName: application
     parameters:
       display-name: incident-management
       provided-apis:
         - name: incident-management-ias-api
           description: API exposed by the application
       oauth2-configuration:
         token-policy:
           access-token-format: "jwt"
       authorization:
         enabled: true

   ams-policies-deployer:
     image:
       repository: incident-management-ams-policies-deployer
     bindings:
       identity:
         serviceInstanceName: identity
         parameters:
           credential-type: X509_GENERATED
           app-identifier: ams-policy-deployer

   hana-deployer:
     image:
       repository: incident-management-hana-deployer
     bindings:
       hana:
         serviceInstanceName: hana
     resources:
       limits:
         cpu: 2000m
         memory: 1G
       requests:
         cpu: 1000m
         memory: 1G

   hana:
     serviceOfferingName: hana
     servicePlanName: hdi-shared

   destination:
     serviceOfferingName: destination
     servicePlanName: lite
     parameters:
       version: 1.0.0
       HTML5Runtime_enabled: true

   html5-apps-repo-host:
     serviceOfferingName: html5-apps-repo
     servicePlanName: app-host

   html5-apps-deployer:
     env:
       SAP_CLOUD_SERVICE: incidentmanagement.service
       IAS_DEPENDENCY_NAME: incident-management-ias-api
     image:
       repository: incident-management-html5-deployer
     bindings:
       identity:
         serviceInstanceName: identity
         parameters:
           credential-type: X509_GENERATED
       destination:
         serviceInstanceName: destination
       html5-apps-repo:
         serviceInstanceName: html5-apps-repo-host
     resources:
       limits:
         cpu: 2000m
         memory: 1G
       requests:
         cpu: 1000m
         memory: 1G
     envFrom:
       - configMapRef:
           name: "{{ .Release.Name }}-html5-apps-deployer-configmap"

   backendDestinations:
     srv-api:
       service: srv
   ```

   </details>


## Troubleshooting Deployment and Access Issues

If there is a misconfiguration in the `values.yaml` file, you might get errors when accessing the applications, Error code `503` or `401`. To resolve such issues, please follow these steps:

1. The value for `IAS_DEPENDENCY_NAME: incident-management-ias-dependency` and `provided-apis - name: incident-management-ias-api` should be same, It will be used later for dependency setup in SAP Build Work Zone.

2. Ensure that the container images are successfully pushed to the container registry.

3. If the pods are failing, check the logs, service instances are in `Created` state in the Kyma runtime.

4. If the backend throws `404`, you can check config-map inside our `incident-management-html5-apps-deployer-configmap`. Check if backend url is there, if it is missing or having a placeholder value, comment this line if present from the `chart/values.yaml` file and redeploy the application.

   ```yaml
   expose:
     gateway: default/kyma-mtls-gateway
     host: "{{ .Release.Name }}-srv-{{ .Release.Namespace }}.cert"
   ```

5. Remove the property `app-identifier: html5-deployer` from the module `html5-apps-deployer` in the `chart/values.yaml` file and redeploy the application.
