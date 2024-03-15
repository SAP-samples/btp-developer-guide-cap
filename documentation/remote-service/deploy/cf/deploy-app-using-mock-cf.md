# Deploy and Run the Application on Cloud Foundry with the Installed Mock Server

## Usage scenario

Deploy the project to Cloud Foundry using the MTA build file.

## Prerequisites

* You have prepared the project for productive usage

### Deploy the Application

1. Navigate to the root folder of incident management application and change credentials in `package.json` file to 

    ```json
        "API_BUSINESS_PARTNER": {
        "kind": "odata", 
        "model": "srv/external/API_BUSINESS_PARTNER", 
        "[production]": { 
          "credentials": { 
            "destination": "<destination_name>",
            "path": "/api-business-partner"
          }
        }
      }
    ```
**Note** - As **destination_name** you must enter the name of the destination created while installing mock server to SAP BTP Cloud Foundry Runtime.

2. In the **mta.yaml** file look for the *incident-management-srv* module *requires* section, add **- name: incident-management-destination-service**
   
    ```yaml
    - name: incident-management-srv
      type: nodejs
      path: gen/srv
      requires:
      - name: incident-management-auth
      - name: incident-management-db
      - name: incident-management-destination-service
    ....
    ```

3. In the **mta.yaml** file add the following code snippet to the *resource* section

    ```yaml
    resources:
      - name: incident-management-destination-service 
        type: org.cloudfoundry.managed-service 
        parameters: 
          service-plan: lite 
          service: destination 
    ...
    ``` 

4. Right-click the `mta.yaml` file and choose **Build MTA Project**
   
   ![build mtar](./images/build_mtar.png)

5. If the build was successful, you find the generated file in the `mta_archives` folder. Right-click on *incidents_1.0.0.mtar* and select **Deploy MTA Archive**  
   
   ![deploy mtar](./images/deploy_mtar.png)

6. Login to your SAP BTP subaccount and space to start the deployment.
   
   ![login](./images/login.png)

   ![login](./images/select_account.png)

Before you can access the application, you need to [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html).

As a next step, to access the application in launchpad, proceed to [Integrate with SAP Build Workzone](https://developers.sap.com/tutorials/integrate-with-work-zone.html).
