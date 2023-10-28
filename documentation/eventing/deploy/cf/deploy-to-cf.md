# Deploy and Run the Application on Cloud Foundry with SAP S/4HANA Cloud Backend

## Usage scenario

In this chapter, you will deploy the project to the SAP BTP, Cloud Foundry runtime using the **cf deploy** command.

## Prerequisites

You have prepared the project for productive usage.

## Content

1. In SAP Business Application Studio open a new terminal.

2. Make sure you are in the project folder of your application and run the following command:

```bash
mbt build
```

3. To deploy the already prepared MTA archive, run the following command:

```bash
cf deploy mta_archives/<mtar>
```

You'll need to [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html) before you can access the application.

Then, proceed to the [Integrate with SAP Build Workzone](https://developers.sap.com/tutorials/integrate-with-work-zone.html) tutorial to access the application in a launchpad.
