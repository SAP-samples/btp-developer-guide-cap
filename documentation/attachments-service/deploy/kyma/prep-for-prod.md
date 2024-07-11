# Configure your application to use the attachments service on Kyma



## Remote Service Configuration

1. Add the following code snippet to `chart/Chart.yaml`:

  ```yaml
  - name: service-instance
    alias: attachments
    version: ">0.0.0"
    repository: https://int.repositories.cloud.sap/artifactory/virtual-unified-runtime-helm-dmz
  - name: service-instance
    alias: malware
    version: ">0.0.0"
    repository: https://int.repositories.cloud.sap/artifactory/virtual-unified-runtime-helm-dmz    
  ```

4. Add the following configuration for `objectstore` service instance creation in `values.yaml`:

  ```yaml
  attachments:
    serviceOfferingName: objectstore
    servicePlanName: s3-standard
  malware:
    serviceOfferingName: malware-scanner
    servicePlanName: clamav   
  ```

5. Find `srv/bindings` object in values.yaml file and add Object Store instance to it

    ```yaml
    srv:
      bindings:
        attachments:
          serviceInstanceName: attachments
        malware:
          serviceInstanceName: malware  
    ```  

For more information about Helm and CAP, see [About CAP Helm chart](https://cap.cloud.sap/docs/guides/deployment/deploy-to-kyma?impl-variant=node#about-cap-helm).


## Next Step
- [Deploy the application to SAP BTP kyma Runtime](./deploy.md)