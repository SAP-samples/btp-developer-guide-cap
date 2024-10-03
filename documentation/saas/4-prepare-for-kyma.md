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
   
2. Build the project using the following command:
   
```shell
cds build --production
```
    
> If the project already has cdm file, skip the next step.
  
3. In the **ui-resources/resources** folder, create a file called **cdm.json** and paste the following:
    > Ensure that the `appId` is matching `app/incidents/manifest.json`->`sap.app.id` . Update the `appId` below with `sap.app.id` of your application.
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
                "appId": "nsincidentswz",
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
                "appId": "nsincidentswz",
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
                "id": "nsincidentswz"
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

1. Automate the setup for HTML5 application deployment by running:
   
```shell
    cds add html5-repo
```

5. Add the following code snippet to **chart/Chart.yaml**  :

```yaml
- name: service-instance
  alias: html5-apps-repo-runtime
  version: ">0.0.0"
```

6. Add the following configurations for creating an html5-apps-repo-runtime service instance in the values.yaml file:

```yaml
html5-apps-repo-runtime: 
  serviceOfferingName: html5-apps-repo
  servicePlanName: app-runtime
```

## Update the Configurations for Multitenancy Support

1. Delete the destination configuration from **chat/values.yaml**:
   
```yaml
    destination:
      serviceOfferingName: 'destination'
      servicePlanName: 'lite'
      parameters:
        version: '1.0.0'
        HTML5Runtime_enabled: true
```
   
2. Delete the destination binding from **chat/values.yaml** whereever it is available.
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
      
    >
    > Update the placeholder values for cluster-domain, namespace and deployment name.
    > Ensure that the indentation is correctly maintained
    
   5. Delete the destination binding. 
   
4. Under **sidecar:bindings:**, add the binding to html5-repository.

```yaml
html5-apps-repo-host:
    serviceInstanceName: html5-apps-repo-host
```

## Build the Images
Once all the configurations are done, build the images and update the image name, version in **chart/values.yaml**.

1. Build the **html5-deployer** image:

```shell
pack build <repository>/incident-management-html5-deployer:<version> \  --path ui-resources \
    --builder paketobuildpacks/builder-jammy-base \
    --publish
```

2. Build the **side-car** image:

```shell
pack build <repository>/incident-management-sidecar:<version> \   --path gen/mtx/sidecar \
     --builder paketobuildpacks/builder-jammy-base \
     --publish
```

3. Build the **srv** image:

```shell
pack build <repository>/incident-management-srv:<version> \   --path gen/srv \
    --builder paketobuildpacks/builder-jammy-base \
    --publish
```

## Next Step
[Deploy the Application in the SAP BTP, Kyma Runtime](./kyma-deployment.md)
