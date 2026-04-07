---
title: Deploy and Run the Incident Management Application in the SAP BTP, Kyma Runtime with SAP S/4HANA Cloud Backend
description: This tutorial shows you how to prepare your application, deploy it to the SAP BTP, Kyma runtime, and test it with SAP S/4HANA Cloud connectivity.
parser: v2
auto_validation: true
time: 45
tags: [ tutorial>intermediate, tutorial>license, software-product-function>sap-cloud-application-programming-model, programming-tool>node-js, software-product>sap-business-technology-platform]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Grzegorz Karaluch
author_profile: https://github.com/grego952
---

## You will learn

- How to connect to your SAP S/4HANA Cloud system.
- How to extend the existing Helm chart with the settings for the SAP S/4HANA Cloud extension service.
- How to test the application with your SAP S/4HANA Cloud system.

## Prerequisites

- You've set up the connection to an SAP S/4HANA Cloud system. Follow the steps in the [Configure Connectivity Between SAP S/4HANA Cloud and SAP Business Technology Platform](remote-service-configure-connectivity) tutorial that is part of the [Consume Remote Services from SAP S/4HANA Cloud in Your Full-Stack CAP Application Following the SAP BTP Developer's Guide and Deploy in SAP BTP, Kyma Runtime](https://developers.sap.com/group.kyma-cap-consume-s4-services.html) tutorial group. 
- You have an [enterprise global account](https://help.sap.com/docs/btp/sap-business-technology-platform/getting-global-account#loiod61c2819034b48e68145c45c36acba6e) in SAP BTP. To use services for free, you can sign up for an SAP BTPEA (SAP BTP Enterprise Agreement) or a Pay-As-You-Go for SAP BTP global account and use the free tier services only. See [Using Free Service Plans](https://help.sap.com/docs/btp/sap-business-technology-platform/using-free-service-plans?version=Cloud).
- You have a platform user. See [User and Member Management](https://help.sap.com/docs/btp/sap-business-technology-platform/user-and-member-management).
- You're an administrator of the global account in SAP BTP.
- You have a subaccount in SAP BTP to deploy the services and applications.

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Prepare the Incident Management application

First, you create a service instance for the SAP S/4HANA Cloud Extensibility service with plan `api-access`. The SAP S/4HANA Cloud system provides pre-defined communication scenarios that contain one or multiple APIs. When creating the service instance, the communication scenario needs to be specified along with some configuration. Under the hood, a communication arrangement based on the given scenario is created in the SAP S/4HANA Cloud system.

1. Create a new file **bupa.json** in the root folder of the project and paste the following code snippet in it:

    ```json
    {
        "systemName": "<SYSTEM_NAME>",
        "communicationArrangement": {
            "communicationArrangementName": "<COMM_NAME>",
            "scenarioId": "SAP_COM_0008",
            "inboundAuthentication": "BasicAuthentication",
            "outboundAuthentication": "BasicAuthentication",
            "outboundServices": [
                {
                    "name": "Replicate Customers from S/4 System to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Replicate Suppliers from S/4 System to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Replicate Company Addresses from S/4 System to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Replicate Workplace Addresses from S/4 System to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Replicate Personal Addresses from S/4 System to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Business Partner - Replicate from SAP S/4HANA Cloud to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Business Partner Relationship - Replicate from SAP S/4HANA Cloud to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Business Partner - Send Confirmation from SAP S/4HANA Cloud to Client",
                    "isServiceActive": false
                },
                {
                    "name": "BP Relationship - Send Confirmation from SAP S/4HANA Cloud to Client",
                    "isServiceActive": false
                }
            ],
            "communicationSystem": {
                "communicationSystemHostname": "default.com",
                "outboundCommunicationUser": {
                    "username": "DefaultUser",
                    "password": "DefaultPassword"
                }
            }
        }
    }
    ```

     - For **systemName**, enter the name of your registered SAP S/4HANA Cloud system. For example, `SAP S/4HANA DEV System`.
     - For **communicationArrangementName**, enter a name for the communication arrangement that is created for the SAP S/4HANA Cloud tenant. For example, `INCIDENT_MANAGEMENT_0008`.


    > For more information, see [Communication Arrangement JSON/YAML File - Properties](https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/553a4c6b98be4c1ba7d1dfa0e9df8669.html).

2.  Navigate to the **package.json** file in the root folder of the application. Add the `[production]` profile `credentials` (`destination` and `path`) to the settings for **API_BUSINESS_PARTNER**:

    ```json
    "API_BUSINESS_PARTNER": {
        "kind": "odata-v2",
        "model": "srv/external/API_BUSINESS_PARTNER",
        "[production]": {
            "credentials": {
                "destination": "incident-management-s4-hana-cloud",
                "path": "/sap/opu/odata/sap/API_BUSINESS_PARTNER"
            }
        }
    }
    ```
    <!-- If you are deploying to Cloud Foundry, the **destination** is `incidents-api-access`. For Kyma, the **destination** is `incident-management-s4-hana-cloud`. -->


2. Open the **chart/Chart.yaml** file and add the following code snippet to it:

    ```yaml
    - name: service-instance
      alias: s4-hana-cloud
      version: ">0.0.0"
    ```

4. Open the **chart/values.yaml** file and add the following code snippet to it:
   
    ```yaml
    s4-hana-cloud:
      serviceOfferingName: s4-hana-cloud
      servicePlanName: api-access
    ....
    ```

### Build images

>- Make sure you're logged in to your Kyma cluster. See [Login to your Kyma cluster](https://developers.sap.com/tutorials/deploy-to-kyma.html#a6e029c1-6e72-408b-bf5f-3b9dffba3499) for detailed steps how to log in.
>
>- Make sure you're logged in to your container registry.
>
>- If you're using any device with a non-x86 processor (for example, MacBook M1/M2), you need to instruct Docker to use x86 images by setting the **DOCKER_DEFAULT_PLATFORM** environment variable using the command `export DOCKER_DEFAULT_PLATFORM=linux/amd64`. Check [Environment variables](https://docs.docker.com/engine/reference/commandline/cli/#environment-variables) for more info.


1. Create the productive CAP build for your application: 

    ```bash
    cds build --production
    ```

    The CAP build writes to the **gen/srv** folder.

4. Build a new version of the CAP Node.js image:

    ```bash
    pack build <your-container-registry>/incident-management-srv:<new-image-version> \
        --path gen/srv \
        --builder paketobuildpacks/builder-jammy-base \
        --publish
    ```

    >- Make sure to replace `<your-container-registry>` with your docker server URL. 
    > 
    >- Keep in mind that `<new-image-version>` is a string that’s different from the string defined in [Deploy in SAP BTP, Kyma Runtime](deploy-to-kyma) to reflect the changes in the Incident Management app. 

    > Looking for your docker server URL?
    
    > The docker server URL is the same as the path used for docker login, so you can quickly check it by running the following command in your terminal:

    > ```json
    > cat ~/.docker/config.json
    > ```

    > In case you're using Docker Hub as your container registry, replace the placeholder `<your-container-registry>` with your Docker Hub user ID.

    > The pack CLI builds the image that contains the build result in the **gen/srv** folder and the required npm packages by using the [Cloud Native Buildpack for Node.JS](https://github.com/paketo-buildpacks/nodejs) provided by Paketo.


7. In the VS Code terminal, navigate to the **ui-resources** folder and run the following command:

    ```bash
    npm install && npm run package
    ```

    This command builds and copies the archive **nsincidents.zip** inside the **ui-resources/resources** folder.

8. In the VS Code terminal, navigate back to the root folder of your project:

    ```bash
    cd ..
    ```

9. Build the UI deployer image:

    ```bash
    pack build <your-container-registry>/incident-management-html5-deployer:<image-version> \
        --path ui-resources \
        --builder paketobuildpacks/builder-jammy-base \
        --publish
    ```

    >- Make sure to replace `<your-container-registry>` with your docker server URL. 
    > 
    >- Keep in mind that `<new-image-version>` is a string that’s different from the string defined in [Deploy in SAP BTP, Kyma Runtime](deploy-to-kyma) to reflect the changes in the Incident Management app.  
    
    > Looking for your docker server URL?
    
    > The docker server URL is the same as the path used for docker login, so you can quickly check it by running the following command in your terminal:

    > ```json
    > cat ~/.docker/config.json
    > ```

    > In case you're using Docker Hub as your container registry, replace the placeholder `<your-container-registry>` with your Docker Hub user ID.

Since the database image is unchanged, you don't need to build it again.


### Deploy the Incident Management application

1. Check your container image settings to your **chart/values.yaml** file:

    ```yaml
    global:
      domain: 
      imagePullSecret:
        name: 
      image:
        registry: <your-container-registry>
        tag: <image-version>
    ```

    > Make sure to replace `<your-container-registry>` with the link to your container registry and keep in mind that `<image version>` is a string. 


2. Overwrite the global image version for the CAP Node.js image and for the UI deployer image:
    
    ```yaml
    srv:
      image:
        repository: incident-management-srv
        tag: <new-image-version>
    ...
    html5-apps-deployer:
      ...
      image:
        repository: "incident-management-html5-deployer"
        tag: <new-image-version>
    ```

3. Update the productive CAP build for your application: 

    ```bash
    cds build --production
    ```

4. Make sure that your SAP HANA Cloud instance is running. Free tier HANA instances are stopped overnight.

    > Your SAP HANA Cloud service instance is automatically stopped overnight, according to the time zone of the region where the server is located. That means you need to restart your instance every day before you start working with it.
    >
    > You can either use the SAP BTP cockpit or the terminal in the SAP Business Application Studio to restart the stopped instance:
    >
    > ```bash
    > cf update-service incident-management -c '{"data":{"serviceStopped":false}}'
    > ```

5. Deploy using the Helm command:

    ```bash
    helm upgrade --install incident-management --namespace incident-management ./gen/chart \
   --set-file xsuaa.jsonParameters=xs-security.json --set-file s4-hana-cloud.jsonParameters=bupa.json
    ```

    This command installs the Helm chart with the release name **incident-management** in the namespace **incident-management**.


### Test the Incident Management application

When creating new entries in the Incident Management application, you see all values from your SAP S/4HANA Cloud system in the value help of the **Customer** field.

> Before you continue with this step, don’t forget to perform the steps from the tutorials [Assign the User Roles](https://developers.sap.com/tutorials/user-role-assignment.html) and [Integrate Your Application with SAP Build Work Zone, Standard Edition](https://developers.sap.com/tutorials/integrate-with-work-zone.html).

1. Open your SAP Build Work Zone, standard edition site as described in [Integrate Your Application with SAP Build Work Zone, Standard Edition](https://developers.sap.com/tutorials/integrate-with-work-zone.html).

6. Choose the Incident Management tile.

    <!-- border; size:540px --> ![Incident Management tile on the launchpage](./incident-management-tile.png)

9. Choose **Create** to start creating a new incident.
  
    <!-- border; size:540px --> ![Create a new incident](./create-new-incident.png)

11. Open the value help for the **Customer** field. 

    <!-- border; size:540px --> ![Value help for Customer field](./value-help-customer.png)

12. Verify that customer data is fetched from the SAP S/4HANA Cloud system. 

    <!-- border; size:540px --> ![Data in value help](./value-help-data1.png)


Congratulations! You have successfully developed, configured, and deployed the Incident Management application using an external service and an SAP S/4HANA Cloud system.