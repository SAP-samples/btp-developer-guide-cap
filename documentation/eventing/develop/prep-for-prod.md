# Prepare the Project for Production

## Introduction

In this chapter you will add the SAP Event Mesh service to your project

## Content

1. Go to SAP Business Application Studio and open a new terminal. Run the command

    ```bash
        cds add enterprise-messaging-shared
    ```

    This will do some adjustments to your project and change the following in your application

    - Adds `"@sap/xb-msg-amqp-v100": "^0"` in package.json file
    - Adds `event-mesh.json` file in the root folder
    - Adds below entry in mta.yaml

        ```yaml
            - name: incidents-messaging
              type: org.cloudfoundry.managed-service
              parameters:
              service: enterprise-messaging
              service-plan: default
              path: ./event-mesh.json`
         ```
    - Adds the below entry in the `requires` section of `incident-management-srv` module

        ```yaml
            - name: incidents-messaging
        ```

2. Open the `mta.yaml` and copy the below module to the  `resources` section.

    ```yaml
    - name: incidents-messaging-cloud
        type: org.cloudfoundry.managed-service
        parameters:
        path: ./s4cems.json
        service: s4-hana-cloud
        service-plan: messaging
        system-name: <enter-your-s4-system-name>
    ```

    > Note: system-name is the created system name you have set in Remote Service Integration tutorial

3. In the root folder of your project create a new file called `s4cems.json`. Copy the below code to it

    ```json
    {
        "emClientId": "emid", 
        "systemName": "<enter-your-s4-system-name>"
    }
    ```

     > Note: system-name is the created system name you have set in Remote Service Integration tutorial
