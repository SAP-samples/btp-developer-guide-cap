---
title: Deploy in SAP BTP, Cloud Foundry Runtime
description: This tutorial shows you how to deploy your CAP application as a multi-target application (MTA).
keywords: cap 
parser: v2
auto_validation: true
time: 45
tags: [ tutorial>beginner, software-product-function>sap-cloud-application-programming-model, programming-tool>node-js, software-product>sap-business-technology-platform, software-product>sap-fiori]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Svetoslav Pandeliev
author_profile: https://github.com/slavipande
---


## You will learn

- How to deploy your CAP application as a multi-target application (MTA) 

## Prerequisites

- You've configured the respective entitlements, enabled the Cloud Foundry runtime in your subaccount, and created an SAP HANA Cloud service instance in the SAP BTP cockpit. Follow the steps in the [Prepare for Deployment in the SAP BTP, Cloud Foundry Runtime](prepare-btp-cf) tutorial that is part of the [Deploy a Full-Stack CAP Application in SAP BTP, Cloud Foundry Runtime Following SAP BTP Developer’s Guide](https://developers.sap.com/group.deploy-full-stack-cap-application.html) tutorial group.
- You have an [enterprise global account](https://help.sap.com/docs/btp/sap-business-technology-platform/getting-global-account#loiod61c2819034b48e68145c45c36acba6e) in SAP BTP. To use services for free, you can sign up for an SAP BTPEA (SAP BTP Enterprise Agreement) or a Pay-As-You-Go for SAP BTP global account and use the free tier services only. See [Using Free Service Plans](https://help.sap.com/docs/btp/sap-business-technology-platform/using-free-service-plans?version=Cloud).
- You have a platform user. See [User and Member Management](https://help.sap.com/docs/btp/sap-business-technology-platform/user-and-member-management).
- You're an administrator of the global account in SAP BTP.
- You have a subaccount in SAP BTP to deploy the services and applications.
- You have a tenant of SAP Cloud Identity Services. See [Get Your Tenant](https://help.sap.com/docs/cloud-identity-services/cloud-identity-services/get-your-tenant) for details how to get a tenant of SAP Cloud Identity Services if you don't have one yet.
- You've established trust between your tenant of SAP Cloud Identity Services and your SAP BTP account. This established trust allows you to use your SAP Cloud Identity Services tenant as an identity provider or a proxy to your own identity provider hosting your business users. See [Establish Trust and Federation Between SAP Authorization and Trust Management Service and SAP Cloud Identity Services](https://help.sap.com/docs/btp/sap-business-technology-platform/establish-trust-and-federation-between-uaa-and-identity-authentication).
- You have one of the following browsers that are supported for working in SAP Business Application Studio:
    - Mozilla Firefox
    - Google Chrome
    - Microsoft Edge

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Introduction

The SAP BTP, Cloud Foundry environment allows you to create polyglot cloud applications in Cloud Foundry. It contains the SAP BTP, Cloud Foundry runtime, which is based on the open-source application platform managed by the Cloud Foundry Foundation.

The SAP BTP, Cloud Foundry environment enables you to develop new business applications and business services, supporting multiple runtimes, programming languages, libraries, and services.

For more information about the Cloud Foundry environment, see [Cloud Foundry Environment](https://help.sap.com/docs/btp/sap-business-technology-platform/cloud-foundry-environment).

### Deploy in the SAP BTP, Cloud Foundry runtime


1. From the root of the **INCIDENT-MANAGEMENT** project, choose the burger menu, and then choose **Terminal** &rarr; **New Terminal**.

2. Log in to your subaccount in SAP BTP:

    ```bash
    cf api <API-ENDPOINT>
    cf login
    cf target -o <ORG> -s <SPACE>
    ```

    > You can find the API endpoint in the **Overview** section of your subaccount in the SAP BTP cockpit.

3. Run the following command to deploy your application to the SAP BTP, Cloud Foundry runtime:

    ```bash
    cds up 
    ```

    > The `cds up` command simplifies the deployment process. It automates the steps that are otherwise done manually:  
    > 
    >  - Adding the mta deployment descriptor with the `cds add mta` command.   
    >  - Building the deployment archive with the `mbt build` command.   
    >  - Deploying to the Cloud Foundry environment with the `cf deploy` command.  

4. Check if all services have been created:

    ```bash
    cf services
    ```

    <!-- border; size:540px --> ![Services after deploy](./cf-services.png)

5. Check if the apps are running:

    ```bash
    cf apps
    ```

    <!-- border; size:540px --> ![App after deploy](./cf-apps.png)

<!-- 6. Enter the route displayed for **incident-management-srv** in your browser. -->

<!-- border; size:540px ![Incident Management route](./incident-management-srv-route.png) -->

<!-- undeploy command: `cf undeploy incident-management --delete-service-keys --delete-services` -->

<!-- You see the CAP start page: -->

<!-- border; size:540px ![CAP start page](./cap-start-page.png) -->

<!-- 4. When you choose the **Incidents** service entity, you will see an error message.  -->

<!-- border; size:540px ![401 error](./401-error.png) -->

<!-- The service expects a so called JWT (JSON Web Token) in the HTTP Authorization header that contains the required authentication and authorization information to access the service.  -->



In the next tutorials, you'll access your UIs from SAP Build Work Zone, standard edition. The SAP Build Work Zone, standard edition triggers the authentication flow to provide the required token to access the service.
