# Prepare the Project for Production

## Introduction

In this chapter you will add the SAP Event Mesh service to your project.

## Procedure

1. Go to SAP Business Application Studio and open a new terminal. Run the following command:

    ```bash
        cds add enterprise-messaging-shared
    ```

    This code adjusts your project and changes your application in the following way:

   - Adds `"@sap/xb-msg-amqp-v100": "^0"` in the **package.json** file
   - Adds the **event-mesh.json** file in the root folder
   - Adds the following entry in the `resources` section of the mta.yaml file:

        ```yaml
            - name: incident-management-messaging
              type: org.cloudfoundry.managed-service
              parameters:
                service: enterprise-messaging
                service-plan: default
                path: ./event-mesh.json`
         ```
    - Adds the following entry in the `requires` section of `incident-management-srv` module:

        ```yaml
            - name: incident-management-messaging
        ```

2. Open the **mta.yaml** file and copy the following module to the  `resources` section:

    ```yaml
    - name: incidents-messaging-cloud
        type: org.cloudfoundry.managed-service
        parameters:
          path: ./s4cems.json
          service: s4-hana-cloud
          service-plan: messaging
          system-name: <enter-your-s4-system-name>
    ```

    > Note: **system-name** is the system name you have set in the Remote Service Integration tutorial.

3. In the root folder of your project, create a new file called **s4cems.json**. Copy the following code to the **s4cems.json** file:

    ```json
    {
        "emClientId": "emid", 
        "systemName": "<enter-your-s4-system-name>"
    }
    ```

     > Note: **system-name** is the system name you have set in the Remote Service Integration tutorial.
     The value of the **emClientId** property should have maximum length of 4 characters and should fit in the [characters: [A-Za-z0-9]; 
