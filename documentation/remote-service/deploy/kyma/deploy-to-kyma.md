# Deploy and Run the Application on Kyma with SAP S/4HANA Cloud Backend

## Usage Scenario

Deploy the project to Kyma using Helm configurations.

## Build Images
To transform source code (or artifacts) into container images, we recommend using [Cloud Native Buildpacks](https://buildpacks.io/).
For local development scenarios, you can use the [pack](https://buildpacks.io/docs/tools/pack/) CLI to consume Cloud Native Buildpacks. 
For more information, see [About Cloud Native Buildpacks](https://cap.cloud.sap/docs/guides/deployment/deploy-to-kyma?impl-variant=node#about-cloud-native-buildpacks).

Log in to your container registry:

```sh
docker login docker.io -u <your-user>

```
## Before You Begin

Please note:

If you're using any device with a non-x86 processor (e.g. MacBook M1/M2), you need to instruct the Docker to use x86 images by setting the **DOCKER_DEFAULT_PLATFORM** environment variable: *export DOCKER_DEFAULT_PLATFORM=linux/amd64*.
See [Environment variables](https://docs.docker.com/engine/reference/commandline/cli/#environment-variables).

### Build CAP Node.js Image

1. Do the productive build for your application, which writes into the `gen/srv` folder:

    ```sh
    cds build --production
    ```

2. Build the image after updating version `<image-version>` to reflect the change in incident-management-srv app.

    ```sh
    pack build <your-container-registry>/incident-management-srv:<image-version> \
        --path gen/srv \
        --builder paketobuildpacks/builder-jammy-base \
        --publish
    ```

**Info**
The pack CLI builds the image that contains the build result in the *gen/srv* folder and the required *npm* packages by using the [Packeto Jammy Base Builder](https://github.com/paketo-buildpacks/builder-jammy-base).

### Build UI Deployer image

1. Create a new folder called `resources` under `app/incidents` and move `webapp` folder to `resources`.
2. Build the image:

    ```sh
    pack build <your-container-registry>/incident-management-html5-deployer:<image-version> \
        --path app/incidents \
        --builder paketobuildpacks/builder-jammy-base \
        --publish
    ```

### Build Database Image 

To build the database image, run:

```sh
pack build <your-container-registry>/incident-management-hana-deployer:<image-version> \
     --path gen/db \
     --builder paketobuildpacks/builder-jammy-base \
     --publish
```

## Remote Service Configuration

1. Add the following code snippet to `chart/Chart.yaml`:

  ```yaml
  - name: service-instance
    alias: s4-hana-cloud
    version: ">0.0.0"
  ```

2. Add the following configurations for `s4-hana-cloud` service instance creation in `values.yaml`:

  ```yaml
  s4-hana-cloud:
    serviceOfferingName: s4-hana-cloud
    servicePlanName: api-access
  ```

For more information about Helm and CAP, see [About CAP Helm chart](https://cap.cloud.sap/docs/guides/deployment/deploy-to-kyma?impl-variant=node#about-cap-helm).


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

```

## Deploy CAP Helm Chart

1. Log in to your Kyma cluster.

2. Deploy using Helm command:

  ```sh
  helm upgrade --install incident-management --namespace incidents-namespace ./chart \
  --set-file xsuaa.jsonParameters=xs-security.json --set-file s4-hana-cloud.jsonParameters=bupa.json
  ```
This installs the Helm chart from the chart folder with the release name ***incident-management*** in the namespace ***incidents-namespace***.

```info
With the ***helm upgrade --install*** command, you can install a new chart as well as upgrade an existing chart.
```

The outcome of installation looks similar to this:

![deployed app](./images/deployedapp.png)

To be able to access the application via the URL, you have to [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html).

As a next step, to access the application in launchpad, proceed to [Integrate with SAP Build Workzone](https://developers.sap.com/tutorials/integrate-with-work-zone.html).

