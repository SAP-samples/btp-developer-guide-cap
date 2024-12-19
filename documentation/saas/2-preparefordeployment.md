# Prepare for Deployment in the SAP BTP, Cloud Foundry Runtime

## Update the MTA File with Multitenancy Configuration 

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
          - name: incident-management-destination # Remove
          - name: incident-management-db
          - name: incident-management-html5-repo-host # Add
  ```

**Remove the  incident-management-destination**

> **NOTE** 
> **Steps 2-6 are optional and are not required if you have already deployed Single Tenant Application with Workzone using CDM** 

2. Add `html5-repo-runtime` under `resources`:

   ```yaml
      resources:
      ...
      - name: incidents_html_repo_runtime
        type: org.cloudfoundry.managed-service
        parameters:
           service: html5-apps-repo
           service-name: incidents-html5-app-runtime-service
           service-plan: app-runtime
   ```
   
3. Update  `incident-management-destinations`:
   
   1. Add
        ```yaml
            - name: incidents_html_repo_runtime
              parameters:
                service-key:
                    name: incidents-html5-app-runtime-service-key
        ```
   
   2. Update  `parameters->content->instance` to `parameters->content->subaccount`.
   3. Delete the destinations under it: 
        
        ```yaml
        - Name: ns_incidents_wz_capire_incidents_repo_host
          ServiceInstanceName: incident-management-html5-srv
          ServiceKeyName: incident-management-repo-host-key
          sap.cloud.service: ns.incidents.wz
        - Authentication: OAuth2UserTokenExchange
          Name: ns_incidents_wz_incidents_auth
          ServiceInstanceName: incident-management-auth
          ServiceKeyName: incident-management-auth-key
          sap.cloud.service: ns.incidents.wz
        ```
    
    4. Add a new destination for the html5 repo runtime under the destination:
        
        ```yaml
        - Name: incident-management_cdm
          ServiceInstanceName: incidents-html5-app-runtime-service
          ServiceKeyName: incidents-html5-app-runtime-service-key
          URL: https://html5-apps-repo-rt.${default-domain}/applications/cdm/<cloud-service-name>

        ```
     > If you are using a extension landscape, you should replace the ${default-domain} with the mail domain, example : eu10-004 to be used as eu-10   
4. Update the `incident-management-app-deployer`:
   
   1. Under the `requires` section, the following dependencies:
      
      ```yaml
        requires:
        - name: srv-api
        - name: incident-management-auth
      ```
   2. Add the following parameters:
      
      ```yaml
        parameters:
           config:
             destinations:
             - forwardAuthToken: true
               name: incident-management-srv-api
               url: ~{srv-api/srv-url}
             - name: ui5
               url: https://ui5.sap.com
      ```
  3. Change the `path` from `gen` to `.`.

The application deployer will look like this: 
```yaml
  - name: incident-management-app-deployer
    type: com.sap.application.content
    path: .
    requires:
      - name: srv-api
      - name: incident-management-auth
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
    parameters:
      config:
        destinations:
        - forwardAuthToken: true
          name: incident-management-srv-api
          url: ~{srv-api/srv-url}
        - name: ui5
          url: https://ui5.sap.com

```
> **The names might differ based on your project configurations.**


1. Update `incident-management-destination` with the following configurations:
  
   1. Under `parameters`, delete `HTML5Runtime_enabled: true`.
   2. Change `instance` to `subaccount`.
   3. Delete the destinations under it and add the following:
      
      ```yaml
        - Authentication: NoAuthentication
          Name: incident-management-rt
          ProxyType: Internet
          CEP.HTML5contentprovider: true
          Type: HTTP
          URL: https://<provider tenant subdomain>.launchpad.${default-domain}
      ```
   
   4. Delete the requires section:  
        ```yaml
            requires:
              - name: srv-api
                group: destinations
                properties:
                  name: srv-api # must be used in xs-app.json as well
                  url: ~{srv-url}
                  forwardAuthToken: true
        ```
2. Update the build parameters if you haven't done this already: 
   
   ```yaml
    build-parameters:
    before-all:
      - builder: custom
        commands:
          - npm ci
          - mkdir -p resources
          - cp workzone/cdm.json resources/cdm.json
          - npx cds build --production    
   ```
3. In the **workzone** folder, create a file called **cdm.json** and paste the following:
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

## Next Step

[Deploy the Incident Management Application in the SAP BTP, Cloud Foundry Runtime](./3-deploy-to-cf.md)
