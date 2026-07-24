# Prepare for Deployment in the SAP BTP, Kyma Runtime

## Prerequisites
1. [Configure your application for Kyma deployment](https://developers.sap.com/group.deploy-full-stack-cap-kyma-runtime.html)
2. [Prepare for Multitenancy](./enable-mtx/1-enable-mtx.md)

## Update Helm Chart for Deployment in the SAP BTP, Kyma Runtime

Once the application is configured for multitenancy and dependency callback handlers are added, more configurations are needed to make it work in multitenancy mode.

1. Configure the Helm chart for multitenancy using the following command at the root of project:
   
```shell
cds add helm
```

> If the project already has a cdm file, skip the next step.
  
2. In the **ui-resources/resources** folder, create a file called **cdm.json** and paste the following:
    > Ensure that the `appId` is matching `app/incidents/webapp/manifest.json`->`sap.app.id`. Update the `appId` below with `sap.app.id` of your application.

```json
    [
        {
        "_version": "3.0",
        "identification": {
            "id": "defaultCatalogId",
            "title": "{{title}}",
            "entityType": "catalog"
        },
        "payload": {
            "viz": [
            {
                "appId": "ns.incidents",
                "vizId": "intent1"
            }
            ]
        },
        "texts": [
            {
            "locale": "",
            "textDictionary": {
                "title": "Default Catalog Title"
            }
            }
        ]
        },
        {
        "_version": "3.0",
        "identification": {
            "id": "defaultGroupId",
            "title": "{{title}}",
            "entityType": "group"
        },
        "payload": {
            "viz": [
            {
                "appId": "ns.incidents",
                "vizId": "intent1"
            }
            ]
        },
        "texts": [
            {
            "locale": "",
            "textDictionary": {
                "title": "Business Apps"
            }
            }
        ]
        },
        {
        "_version": "3.0",
        "identification": {
            "id": "defaultRole",
            "entityType": "role",
            "title": "Default Role"
        },
        "payload": {
            "apps": [
            {
                "id": "ns.incidents"
            }
            ],
            "catalogs": [
            {
                "id": "defaultCatalogId"
            }
            ],
            "groups": [
            {
                "id": "defaultGroupId"
            }
            ]
          }
       }
    ]
```

3. Add the following code snippet to **chart/Chart.yaml**:

```yaml
- name: service-instance
  alias: html5-apps-repo-runtime
  version: ">0.0.0"
```

## Update the Configurations for Multitenancy Support

1. Delete the destination configuration from **chart/values.yaml**:
   
```yaml
    destination:
      serviceOfferingName: 'destination'
      servicePlanName: 'lite'
      parameters:
        version: '1.0.0'
        HTML5Runtime_enabled: true
```
   
2. Remove all instances of the destination binding from the `chart/values.yaml` file.

3. Under **html5-apps-deployer**, do the following:

   1. Delete **SAP_CLOUD_SERVICE**.
   2. Delete **envFrom:** and the fields under it:
   
        ```yaml
        envFrom:
        - configMapRef:
            name: "{{ .Release.Name }}-html5-apps-deployer-configmap"
        ```
        
   3. Delete **backendDestinations:** and its properties.
   4. Under **env**, add the following:
       
       ```yaml
         env:
           ASYNC_UPLOAD: "true"
           destinations: '[{"forwardAuthToken":true,"name":"srv-api","url":"https://<deployment-name>-srv-<namespace>.<cluster-domain>"}]'
        ```
      
    > Update the placeholder values for cluster-domain, namespace and deployment name.
    > Ensure that the indentation is correctly maintained.
    
   5. Delete the destination binding.
   
4. Under **sidecar:bindings:**, add the binding to html5-repository:

```yaml
html5-apps-repo-host:
    serviceInstanceName: html5-apps-repo-host
```

5. Add the following `html5-apps-repo-runtime` service instance configuration to **chart/values.yaml**:

```yaml
html5-apps-repo-runtime: 
  serviceOfferingName: html5-apps-repo
  servicePlanName: app-runtime
```

> **Note:** This entry is required for tenant subscription to succeed. Without it, the sidecar dependency callback fails with a 500 error.

6. Build the project:
   
```shell
cds build --production
```

## Build the Images

Configure `containerize.yaml` at the root of your project. Once all configurations are done, deploy with `cds up`.

> **Note:** Set `BP_NODE_VERSION: "20"` to pin Node.js to version 20 LTS. Without it, the Paketo buildpack selects Node.js 26, which requires `libatomic.so.1` — a library not present in the `paketobuildpacks/run-jammy-base` runtime image, causing the container to crash on startup.

```yaml
_schema-version: '1.0'
repository: <your-dockerhub-username>
tag: <image-version>
modules:
  - name: incident-management-html5-deployer
    build-parameters:
      buildpack:
        type: nodejs
        builder: builder-jammy-base
        path: ui-resources
  - name: incident-management-sidecar
    build-parameters:
      buildpack:
        type: nodejs
        builder: builder-jammy-base
        path: gen/mtx/sidecar
        env:
          BP_NODE_VERSION: "20"
  - name: incident-management-srv
    build-parameters:
      buildpack:
        type: nodejs
        builder: builder-jammy-base
        path: gen/srv
        env:
          BP_NODE_VERSION: "20"
```

Update the image names and versions in **chart/values.yaml**:

> **Note:** The `global.image.registry` field must be a valid registry domain (e.g. `docker.io`). A bare Docker Hub username is not valid and will cause `cds up` to fail with a registry validation error.

```yaml
global:
  domain: <your-kyma-cluster-domain>
  imagePullSecret:
    name: <image-pull-secret-name>
  imagePullPolicy: Always
  image:
    registry: docker.io
    tag: <image-version>
srv:
  image:
    repository: <your-dockerhub-username>/incident-management-srv
sidecar:
  image:
    repository: <your-dockerhub-username>/incident-management-sidecar
html5-apps-deployer:
  image:
    repository: <your-dockerhub-username>/incident-management-html5-deployer
```

## Next Step
[Deploy the Application in the SAP BTP, Kyma Runtime](./kyma-deployment.md)
