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


