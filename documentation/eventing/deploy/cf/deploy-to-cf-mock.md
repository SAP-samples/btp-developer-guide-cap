# Prepare the Project for Production

## Introduction

In this chapter you will add the SAP Event Mesh service to your project

## Content

1. Go to SAP Business Application Studio and open a new terminal. Run the command

    ```bash
        cds add enterprise-messaging-shared
    ```

    This command will do some adjustments to your project and change the following in your application

    - Adds `"@sap/xb-msg-amqp-v100": "^0"` in package.json file
    - Adds `event-mesh.json` file in the root folder
    - Adds below entry in mta.yaml

        ```yaml
            - name: inicdent-management-messaging
              type: org.cloudfoundry.managed-service
              parameters:
              service: enterprise-messaging
              service-plan: default
              path: ./event-mesh.json`
         ```
    - Adds the below entry in the `requires` section of `incident-management-srv` module

        ```yaml
            - name: inicdent-management-messaging
        ```

2. Make sure you are in the project folder of your application and run command

        ```bash
        mbt build
        ```

3. To deploy the ready MTA archive execute the following command:

```bash
cf deploy mta_archives/<mtar>
```

You'll need to [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html) before you can access the application.

Next step, proceed to [Integrate with SAP Build Workzone](https://developers.sap.com/tutorials/integrate-with-work-zone.html) to access the application in launchpad.


