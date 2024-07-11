# Deploy and Run the Application on Cloud Foundry with SAP Attachments Service

## Usage Scenario

Deploy the project to Cloud Foundry using the MTA build file.

## Prerequisites

* You have prepared the project for productive usage.


### Deploy the Application


1. Right-click on the *mta.yaml* file and choose **Build MTA Project**
   
   ![build mtar](./../../../remote-service/deploy/cf/images/build_mtar.png)

2. If the build was successful, you find the generated file in the *mta_archives* folder. Right-click on *incident-management_1.0.0.mtar* and choose **Deploy MTA Archive**.
   
   ![deploy mtar](./../../../remote-service/deploy/cf/images/deploy_mtar.png)

3. Login to your SAP BTP subaccount and space to start the deployment.
   
   ![login](./../../../remote-service/deploy/cf/images/login.png)

   ![login](./../../../remote-service/deploy/cf/images/select_account.png)


Before you can access the application, you need to [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html).

As a next step, proceed to [Integrate with SAP Build Workzone](https://developers.sap.com/tutorials/integrate-with-work-zone.html) to access the application in launchpad.
