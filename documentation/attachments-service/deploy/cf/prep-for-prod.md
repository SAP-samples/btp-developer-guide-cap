# Configure your application to use the attachments service on Cloud Foundry

## Configure the MTA

1. Right-click on the *mta.yaml* file and choose **Open with ... - Text Editor**.
2. Add the following code snippet to the *resource* section

    ```yaml
    - name: incident-management-attachments
      type: org.cloudfoundry.managed-service
      parameters:
        service: objectstore
        service-plan: s3-standard
    - name: incident-management-malware
      type: org.cloudfoundry.managed-service
      parameters:
        service: malware-scanner
        service-plan: clamav     
    ```

3. In the *incident-management-srv* module, in the *requires* section, add the dependencies as shown for **incident-management-attachments** and **incident-management-malware**
   
    ```yaml
    - name: incident-management-srv
      type: nodejs
      path: gen/srv
      requires:
      - name: incident-management-auth
      - name: incident-management-db
      - name: incident-management-attachments
      - name: incident-management-malware      
    ....
    ```

## Next Step
- [Deploy the application to SAP BTP Cloud Foundry Runtime](./deploy.md)
