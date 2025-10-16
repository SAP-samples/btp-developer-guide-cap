# Prepare for Deployment in the SAP BTP, Cloud Foundry Runtime

## Update the MTA File With Multitenancy Configuration 

To deploy a multitenant application and access it in the subscriber subaccount through SAP Build Work Zone, there is a need to update the MTA configuration for design time and runtime configurations. 
In the `mta.yaml` file, update the following configurations:

1. Add dependencies to `incident-management-mtx`. To get the reuse dependent services, add the following services to the required section:
  
  ```yaml
    - name: incident-management-mtx
        type: nodejs
        path: gen/mtx/sidecar
        build-parameters:
        builder: npm-ci
        parameters:
        memory: 256M
        disk-quota: 512M
        provides:
        - name: mtx-api
            properties:
            mtx-url: ${default-url}
        requires:
          - name: incident-management-registry
          - name: incident-management-auth
          - name: incident-management-html5-repo-host
          - name: incident-management-destination # Remove
          - name: incident-management-html5-runtime # Remove
          - name: incident-management-db
  ```

**Remove the incident-management-destination**

2. Since `destination` is not needed, ensure that `mtx/sidecar/package.json` doesn't contain `"destinations": true,`, If there, Delete it.
3. Delete the `"html5-runtime": true` from `mtx/sidecar/package.json`.

> [!NOTE]
> **Steps 4-6 are optional** and are not required if you have already deployed a Single Tenant Application with SAP Build Work Zone using CDM.
   
4. Update  `incident-management-destinations`-> `type: com.sap.application.content` with the following configurations:
  
   1. Delete the instance level destinations under it: 
        ```yaml
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
        ```
    
    2. Add a new destination for the CDM under the destination:
        
        ```yaml
        subaccount:
          existing_destinations_policy: update
          destinations:
            - Name: incident-management_cdm
              ServiceInstanceName: incident-management-html5-runtime
              ServiceKeyName: incident-management-html5-runtime-service-key
              URL: https://html5-apps-repo-rt.${default-domain}/applications/cdm/incidentmanagement.service

        ```
        > [!NOTE]
        `<cloud.service>` should be replace with your cloud.service value
        If you are using an extension landscape, you should replace the ${default-domain} with the mail domain, example : eu10-004 to be used as eu-10

      3. Under `requires` add the following
   
      ```yaml
       - name: incident-management-html5-runtime
        parameters:
          service-key: 
            name: incident-management-html5-runtime-service-key
      ```
> [!NOTE]
> The Service Names `incident-management-html5-runtime` might differ based on your project configurations. You can Check the resources section in `mta.yaml` for the html5-repo-runtime service name.


5. Update `incident-management-destination`->`type: org.cloudfoundry.managed-service` with the following configurations:
  
   1. Under `parameters`, delete `HTML5Runtime_enabled: true`.
   2. **Delete** the `instance` destinations under it:
      
      ```yaml
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
      ```
   3. Delete the requires section:  
        ```yaml
            requires:
              - name: srv-api
                group: destinations
                properties:
                  name: srv-api # must be used in xs-app.json as well
                  url: ~{srv-url}
                  forwardAuthToken: true
        ```

6. Create a new module `incident-management-workzone-cdm` to add the CDM Configuration from the cdm.json file as part of the `incident-management-app-deployer`.

7. In the `mta.yaml` file, add the following module under `modules`:
   
```yaml
- name: incident-management-workzone-cdm
  type: html5
  path: workzone
  build-parameters:
    build-result: .
    supported-platforms:
      []
```

8. Add the following to the `build-parameters.requires` section:

```yaml
- name: incident-management-workzone-cdm
    artifacts:
      - cdm.json
    target-path: app/

```
9. Update the `parameters` field of `incident-mangement-app-deployer` with the following value:
```yaml
    parameters:
      config:
        destinations:
        - forwardAuthToken: true
          name: srv-api
          url: ~{srv-api/srv-url}
        - name: ui5
          url: https://ui5.sap.com
```


The application deployer will look like this: 

```yaml
  - name: incident-management-app-deployer
    type: com.sap.application.content
    path: gen 
    requires:
      - name: incident-management-auth
      - name: srv-api
      - name: incident-management-html5-repo-host
        parameters:
          content-target: true
    build-parameters:
      build-result: app/
      requires:
        - name: incidentmanagementincidents
          artifacts:
            - incidents.zip
          target-path: app/
        - name: incident-management-workzone-cdm
          artifacts:
            - cdm.json
          target-path: app/
    parameters:
      config:
        destinations:
        - forwardAuthToken: true
          name: srv-api
          url: ~{srv-api/srv-url}
        - name: ui5
          url: https://ui5.sap.com
```

1. Create a **workzone** folder on the root of the project then create a file named **cdm.json** and paste the following:
    > Ensure that the `appId` is matching `app/incidents/manifest.json`->`sap.app.id`. Update the `appId` below with `sap.app.id` of your application.
    > Ensure that the `"vizId": "incidents-display"` is matching `crossNavigation->inbounds-><vizId>` In this case `<vizId>` is `incidents-display`.

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
                "vizId": "incidents-display"
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
                "vizId": "incidents-display"
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

  
## Next Step

[Deploy the Incident Management Application in the SAP BTP, Cloud Foundry Runtime](./4-deploy-to-cf.md)
