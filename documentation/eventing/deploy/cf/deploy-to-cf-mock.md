# Prepare the Project for Production

## Introduction

In this chapter you will add the SAP Event Mesh service to your project.

## Procedure

1. Go to SAP Business Application Studio and open a new terminal. Run the following command:

    ```bash
        cds add enterprise-messaging-shared
    ```

    This command adjusts to your project and changes the application in the following way:

    - Adds `"@sap/xb-msg-amqp-v100": "^0"` in the **package.json** file:
    - Adds the **event-mesh.json** file in the root folder
    - Adds the following entry in the mta.yaml file:

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

2. Make sure you are in the project folder of your application and run the following command:

        ```bash
        mbt build
        ```

3. To deploy the ready MTA archive, run the following command:

```bash
cf deploy mta_archives/<mtar>
```

You'll need to [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html) before you can access the application.

Then, proceed to the [Integrate with SAP Build Workzone](https://developers.sap.com/tutorials/integrate-with-work-zone.html) tutorial to access the application in a launchpad.


