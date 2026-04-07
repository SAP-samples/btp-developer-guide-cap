---
title: Set Up SAP Business Application Studio
description: SAP Business Application Studio is a development environment available on SAP Business Technology Platform (BTP). Before you can start developing applications with SAP Business Application Studio, you must perform the required onboarding steps that are described in this tutorial.
parser: v2
auto_validation: true
time: 20
tags: [ tutorial>beginner, programming-tool>sapui5, software-product>sap-business-technology-platform, software-product>sap-fiori, software-product-function>sap-cloud-application-programming-model]
primary_tag: software-product>sap-business-application-studio
author_name: Svetoslav Pandeliev
author_profile: https://github.com/slavipande
---

## You will learn

- How to subscribe to SAP Business Application Studio.
- How to launch SAP Business Application Studio.

## Prerequisites

- You have an [enterprise global account](https://help.sap.com/docs/btp/sap-business-technology-platform/getting-global-account#loiod61c2819034b48e68145c45c36acba6e) in SAP BTP. To use services for free, you can sign up for an SAP BTPEA (SAP BTP Enterprise Agreement) or a Pay-As-You-Go for SAP BTP global account and use the free tier services only. See [Using Free Service Plans](https://help.sap.com/docs/btp/sap-business-technology-platform/using-free-service-plans?version=Cloud).
- You have a platform user. See [User and Member Management](https://help.sap.com/docs/btp/sap-business-technology-platform/user-and-member-management).
- You're an administrator of the global account in SAP BTP.
- You have a subaccount in SAP BTP to deploy the services and applications.
- You have one of the following browsers that are supported for working in SAP Business Application Studio:
    - Mozilla Firefox
    - Google Chrome
    - Microsoft Edge

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Configure entitlements for SAP Business Application Studio

> This task is done by the administrator of the global account in SAP BTP. Developers then need to create their personal development space by following the instructions in **Step 4: Launch SAP Business Application Studio**.
  
1. In the SAP BTP cockpit, choose **Entitlements** &rarr; **Entity Assignments**.

2. In the **Subaccounts/Directories** field, select the subaccount you have already created.

3. Choose **Edit** and then choose **Add Service Plans**.

4. In the **Add Service Plans** dialog, search for **SAP Business Application Studio** and select plan **free (Application)**.

    > The plan **free (Application)** has the following restrictions:
    >
    >- A user can only have up to 2 dev spaces.
    >- A user can only have 1 dev space in the **RUNNING** state at a time.
    >- When working in the **Full-Stack Application Using Productivity Tools** dev space, a user can deploy a maximum of 2 times.
    >- The maximum size limit of a dev space is 4 GB. 

5. Choose **Add 1 Service Plan**.

    <!-- border; size:540px --> ![Screenshot showing the SAP BTP Cockpit logged in, with the entitlements entry highlighted on the left sidebar indicating it's selected, the "Add Service Plans" highlighted in the entitlements section on the right indicating it's clicked, a popover is visible in which you can find and add entitlements, the entry for "SAP Business Application Studio" is selected and the plan "free (Application) is checked finally the "Add 1 Service Plan" button is highlighted.](./bas-entitlement.png)

6. Choose **Save**.


### Subscribe to the SAP Business Application Studio

> This task is done by the administrator of the global account in SAP BTP. Developers then need to create their personal development space by following the instructions in **Step 4: Launch SAP Business Application Studio**.

1. Navigate to your subaccount and choose **Services** &rarr; **Service Marketplace**.

2. Search for the **SAP Business Application Studio** tile and choose **Create**.

    <!-- border; size:540px --> ![screenshot showing the "three dots menu" for SAP Business Application Studio in the Service Marketplace. after opening the menu an option to create an SAP Business Application Studio Instance is seen.](./bas-create.png)

3. In the **New Instance or Subscription** popup, select **free** from the dropdown in the **Plan** field and choose **Create**.

    <!-- border; size:540px --> ![SAP Business Application Studio, create free plan instance](./bas-create-free.png)

    > Creating your new subscription takes some minutes. You can check the current status of the submission on the **Service Instances and Subscriptions** page.

### Assign the necessary roles to your user

> This task is done by the administrator of the global account in SAP BTP. Developers then need to create their personal development space by following the instructions in **Step 4: Launch SAP Business Application Studio**.

1. Navigate to your subaccount and choose **Security** &rarr; **Users**.

2. Select your user from the list and choose **Assign Role Collection**.

    <!-- border; size:540px --> ![SAP Business Application Studio: Assign Role Collection](./bas-assign-role-collection.png)

3. In the **Assign Role Collection** popup, select the **Business_Application_Studio_Developer** role collection and choose **Assign Role Collection**.

    <!-- border; size:540px --> ![Assign Rol Collection popup](./bas-assign-role-collection-popup.png)

    > You can find an overview about the role collections in [Manage Role Collections](https://help.sap.com/docs/bas/sap-business-application-studio/manage-role-collections) on the SAP Help Portal.

### Launch SAP Business Application Studio

1. Navigate to your subaccount and choose **Services** &rarr; **Instances and Subscriptions**.

2. Choose the **SAP Business Application Studio** subscription. SAP Business Application Studio opens in a new tab of the browser.

3. Choose **Create Dev Space**.

    If you haven't created a dev space, the welcome page for SAP Business Application Studio loads.

    <!-- border; size:540px --> ![SAP Business Application Studio welcome](./bas-welcome.png)

    If you have already created another dev space, the dev space manager for SAP Business Application Studio loads.

    <!-- border; size:540px --> ![SAP Business Application Studio welcome](./bas-welcome-1.png)

    > If you create a bookmark to this page, it's easy to get back to SAP Business Application Studio later.

4. Enter a **Dev Space Name**. For example, **IncidentManagement**.

5. Choose the **Full Stack Cloud Application** template and then choose **Create Dev Space**.

    <!-- border; size:540px --> ![SAP Business Application Studio Create Dev Space](./bas-create-dev-space.png)

    > Creating your dev space takes some minutes.

6. As soon as your dev space is in status **Running**, you can click its name to open it.

    <!-- border; size:540px --> ![SAP Business Application Studio Create Dev Space](./bas-open-dev-space.png)

You've successfully completed the setup of SAP Business Application Studio.
