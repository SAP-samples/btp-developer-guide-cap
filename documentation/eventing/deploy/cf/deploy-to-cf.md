# Deploy and Run the Application on Cloud Foundry with SAP S/4HANA Cloud Backend

## Usage scenario

Deploy the project to Cloud Foundry using the cf deploy command

## Prerequisites

* You have prepared the project for productive usage

## Content

1. In **SAP Business Application Studio** open a new Terminal 

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