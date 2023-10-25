# Deploy and Run the Application on Kyma with SAP S/4HANA Cloud Backend

## Usage scenario

Deploy the project to SAP BTP Kyma runtime using [Helm](https://helm.sh/) Configurations

## Prepare for Production

1. Navigate to package.json file in the root folder of your application.

2. Add `"@sap/xb-msg-amqp-v100": "^0"` to the **dependencies** section of package.json file.

3. Add the below code to the **requires** section of package.json file

    ```json
    "messaging": {
        "kind": "local-messaging",
        "[production]": {
          "kind": "enterprise-messaging-shared",
          "format": "cloudevents"
        }
      },
    ```

5. Create a new file called event-mesh.json at the root folder of the project and copy the below content. 

     - As **EM_NAME** you must enter a speaking name for your client (e.g. inicidents-emname).

        ```json
        {
        "emname": "<EM_NAME>",
        "version": "1.1.0",
        "namespace": "default/incidents/1",
        "options": {
            "management": true,
            "messagingrest": true,
            "messaging": true
        },
        "rules": {
            "topicRules": {
            "publishFilter": [
                "${namespace}/*"
            ],
            "subscribeFilter": [
                "*"
            ]
            },
            "queueRules": {
            "publishFilter": [
                "${namespace}/*"
            ],
            "subscribeFilter": [
                "${namespace}/*"
            ]
            }
        },
        "authorities": [
            "$ACCEPT_GRANTED_AUTHORITIES"
        ]
        }
        ```

## Build Images
We recommend using [Cloud Native Buildpacks](https://buildpacks.io/) to transform source code (or artifacts) into container images. For local development scenarios, you can use the [pack](https://buildpacks.io/docs/tools/pack/) CLI to consume Cloud Native Buildpacks. Check out [About Cloud Native Buildpacks](https://cap.cloud.sap/docs/guides/deployment/deploy-to-kyma?impl-variant=node#about-cloud-native-buildpacks) for more info.

Log in to your container registry:

```sh
docker login docker.io -u <your-user>

```
## Before you begin

Please note the following points:

If you're using any device with a non-x86 processor (e.g. MacBook M1/M2) you need to instruct the Docker to use x86 images by setting the [DOCKER_DEFAULT_PLATFORM](https://docs.docker.com/engine/reference/commandline/cli/#environment-variables) environment variable.
export DOCKER_DEFAULT_PLATFORM=linux/amd64

### Build CAP Node.js Image

1. Do the productive build for your application, which writes into the `gen/srv` folder:

    ```sh
    cds build --production
    ```

2. Build the image:

    ```sh
    pack build <your-container-registry>/incident-management-srv:<image-version> \
        --path gen/srv \
        --builder paketobuildpacks/builder-jammy-base \
        --publish
    ```

**Info**
The pack CLI builds the image that contains the build result in the gen/srv folder and the required npm packages by using the [Packeto Jammy Base Builder](https://github.com/paketo-buildpacks/builder-jammy-base).

### Build UI Deployer image

 Build the image:
 
  ```sh
    pack build <your-container-registry>/incident-management-html5-deployer:<image-version> \
        --path app/incidents \
        --builder paketobuildpacks/builder-jammy-base \
        --publish
  ```

### Build Database Image 

Run the below command to build the database image:

```sh
pack build <your-container-registry>/incident-management-hana-deployer:<image-version> \
     --path gen/db \
     --builder paketobuildpacks/builder-jammy-base \
     --publish
```

## Create Event Mesh Service Instance

1. Navigate to 

## Eventing Configuration
> This section is needed only if you are going to use SAP S/4HANA Cloud system as your remote service.

1. Create a new file called s4cems.json at the root folder of the project and copy the below content.
 
 - As **emClientId** you must enter a speaking name for your client (e.g. INCI).
 - As **systemName** you must enter the name of your the registered SAP S/4HANA Cloud system. 

    ```json
        {
        "emClientId": "<EMID>", 
        "systemName": "<SYSTEM_NAME>"
        }
    ``` 

2. Navigate to chart/Chart.yaml file from the project root folder.

3. Add the following code snippet to the Chart.yaml to create s4hana cloud extensibility service instance with messaging plan

    ```yaml
    - name: service-instance
        alias: s4-hana-cloud-messaging
        version: ">0.0.0"
    ```

3. Add the below configurations for `s4-hana-cloud` to the values.yaml

    ```yaml
    s4-hana-cloud-messaging:
        serviceOfferingName: s4-hana-cloud
        servicePlanName: messaging
    ```

More info about Helm and CAP in [About CAP Helm chart](https://cap.cloud.sap/docs/guides/deployment/deploy-to-kyma?impl-variant=node#about-cap-helm).

## Deploy Helm Chart
Once your cluster is prepared, your container images are built and uploaded to a registry, and your Helm chart is created, you're almost set for deploying your Kyma application.

### Configure Access to Your Container Images

1. Add your container image settings to your `chart/values.yaml`:

```yaml{4,7,8,9,13,14,18,19,23,24}
...
global:
  imagePullSecret:
    name: [<image pull secret name>] 
...
srv:
  image:
    repository: <your-container-registry>/incident-management-srv
    tag: <srv-image-version>
...
hana-deployer:
  image:
    repository: <your-container-registry>/incident-management-hana-deployer
    tag: <db-deployer-image-version>
...
html5-apps-deployer:
  image:
    repository: <your-container-registry>/incident-management-html5-deployer
    tag: <html5apps-deployer-image-version>

2. Change the value for `SAP_CLOUD_SERVICE` to `incidents`
```yaml{3}
html5-apps-deployer:
  env:
    SAP_CLOUD_SERVICE: incidents
```

### Configure Cluster Domain

1. Specify the domain of your cluster in the `chart/values.yaml` file so that the URL of your CAP service can be generated:

```yaml
...
domain: <cluster domain>

```
You can use the following command to get the domain name for your Kyma cluster:

```yaml
kubectl get gateway -n kyma-system kyma-gateway \
        -o jsonpath='{.spec.servers[0].hosts[0]}'
```

2. Replace `<your-cluster-domain>` with your cluster domain in the `xsuaa` section of the `values.yaml` file:
```yaml
xsuaa:
  serviceOfferingName: xsuaa
  servicePlanName: application
  parameters:
    xsappname: incidents
    tenant-mode: dedicated
    oauth2-configuration:
      redirect-uris:
        - https://*.<your-cluster-domain>/**

```
3. Add the destinations under `backendDestinations` in the `values.yaml` file:

```yaml
backendDestinations:
  inicdent-management-srv-api:
    service: srv
```
**info**
`backend` is the name of the destination. `service` points to the deployment name whose URL will be used for this destination.
:::

4. Add a configuration to create SAP Event Mesh service instance in `values.yaml` file

  ```yaml
  event-mesh:
    serviceOfferingName: enterprise-messaging
    servicePlanName: default
  ```

5. Navigate to `chart/Chart.yaml` and add the below configurations

  ```yaml
  - name: service-instance
    alias: event-mesh
    version: ">0.0.0"
  ```

## Deploy CAP Helm Chart

1. Log in to your Kyma cluster.

2. Deploy using Helm command:
  
  - with SAP S/4HANA Cloud 

  ```sh
  helm upgrade --install incident-management --namespace incidents-namespace ./chart \
    --set-file xsuaa.jsonParameters=xs-security.json --set-file s4-hana-cloud.jsonParameters=bupa.json --set-file s4-hana-cloud-messaging.jsonParameters=s4cems.json --set-file event-mesh.jsonParameters=event-mesh.json
  ```

  - without SAP S/4HANA Cloud 
  >In this case you will be using a mock server. Installation for mock server comes in the upcoming tutorials

  ```sh
  helm upgrade --install incident-management --namespace incidents-namespace ./chart \
    --set-file xsuaa.jsonParameters=xs-security.json --set-file event-mesh.jsonParameters=event-mesh.json
  ```

This installs the Helm chart from the chart folder with the release name ***incident-management*** in the namespace ***incidents-namespace***.

> With the ***helm upgrade --install*** command you can install a new chart as well as upgrade an existing chart.

The outcome of installation will look something like this:

![deployed app](../images/deployedapp.png)

You have to [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html) to be able to access the application via the URL.

Next step, proceed to [Integrate with SAP Build Workzone](https://developers.sap.com/tutorials/integrate-with-work-zone.html) to access the application in launchpad.
