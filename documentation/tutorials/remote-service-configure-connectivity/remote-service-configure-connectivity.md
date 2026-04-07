---
title: Configure Connectivity Between SAP S/4HANA Cloud and SAP Business Technology Platform
description: This tutorial shows you how to add your SAP S/4HANA Cloud system to your global account in SAP BTP.
parser: v2
auto_validation: true
time: 30
tags: [ tutorial>intermediate, tutorial>license, software-product-function>sap-cloud-application-programming-model, programming-tool>node-js, software-product>sap-business-technology-platform]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Svetoslav Pandeliev
author_profile: https://github.com/slavipande
---

## You will learn

 - How to acquire an SAP BTP integration token.
 - How to add integration token to SAP S/4HANA Cloud system.
 - How to set up entitlements for your SAP BTP subaccount.

## Prerequisites

 - You've tested the extended Incident Management application with the Business Partner API. Follow the steps in the [Test the Extended Incident Management Application with the Business Partner API](remote-service-run-dev-test) tutorial that is part of the [Consume Remote Services from SAP S/4HANA Cloud in Your Full-Stack CAP Application Following the SAP BTP Developer's Guide and Deploy in SAP BTP, Cloud Foundry Runtime](https://developers.sap.com/group.sap-s4hana-consume-remote-services.html) tutorial group.
 - On SAP BTP side:
     - You have an [enterprise global account](https://help.sap.com/docs/btp/sap-business-technology-platform/getting-global-account#loiod61c2819034b48e68145c45c36acba6e) in SAP BTP. To use services for free, you can sign up for an SAP BTPEA (SAP BTP Enterprise Agreement) or a Pay-As-You-Go for SAP BTP global account and use the free tier services only. See [Using Free Service Plans](https://help.sap.com/docs/btp/sap-business-technology-platform/using-free-service-plans?version=Cloud).
     - You have a platform user. See [User and Member Management](https://help.sap.com/docs/btp/sap-business-technology-platform/user-and-member-management).
     - You must be an administrator of the SAP BTP global account where you want to register your SAP S/4HANA Cloud system.
     - You have a subaccount in SAP BTP to deploy the services and applications.
 - On SAP S/4HANA Cloud side:
    - You have a dedicated SAP S/4HANA Cloud tenant.
    - You must be an administrator of the SAP S/4HANA Cloud system.
    - You need to connect this system to your SAP BTP global account, if you want to build extension applications for your SAP S/4HANA Cloud system.

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Add a system to your SAP BTP account

1. In the SAP BTP cockpit, open your global account and choose **System Landscape**.

2. In the **System Landscape** screen, choose **Systems** and then **Add System**.

     <!-- border; size:540px --> ![Add system](./add-system-button.png)

3. In the **Add System** dialog box, enter a name for the SAP S/4HANA Cloud system you want to connect.

    > Use a name that uniquely identifies this system. For example, use the name **SAP S/4HANA DEV System**.

4. Select **SAP S/4HANA Cloud** from the dropdown in the **Type** field and choose **Add**. 

     <!-- border; size:540px --> ![Add System dialog](./add-system-dialog.png)

6. In the **Get Token for System "S/4HANA DEV System"**, select **All Communication Scenarios** from the dropdown in the **Communication Scenario Groups** field and choose **Get Token**.

     <!-- border; size:540px --> ![Get token](./get-token.png)

     SAP BTP generates an integration token so the SAP S/4HANA Cloud system administrator can configure integration with SAP BTP from your SAP S/4HANA Cloud system. 

9. Copy the generated token and close the dialog box. You need the token in the following procedure.

     <!-- border; size:540px --> ![Copy token](./copy-token.png)

  

### Add integration token to SAP S/4HANA Cloud system

1. Log on to your SAP S/4HANA Cloud tenant.

2. Choose **Administration** &rarr; **Communication Management** and choose the tile **Maintain Extensions on SAP BTP**.

     <!-- border; size:540px --> ![Communication Management](./communication-management-screen.png)

3. On the **Maintain Extensions on SAP BTP** screen in the **Extensions** section, choose **New**.

     <!-- border; size:540px --> ![New extension](./new-extension-button.png)

4. In the **Integration Token** field, paste the integration token you previously generated.

5. Enter a **Description** for your system integration token and choose **Create**.

     <!-- border; size:540px --> ![Paste integration token](./paste-token.png)

    > Use the same name that you entered in the SAP BTP cockpit when you generated the token. For example, use the name **SAP S/4HANA DEV System**.
     

6. Choose **Yes** to approve the creation, and wait until the status displayed for your newly registered system switches to **Enabled**. Refresh your page.

     <!-- border; size:540px --> ![Extension enabled](./extension-enabled.png)

     At the same time, you see the system status updated to **Registered** on the SAP BTP side. Refresh the page for the status to be updated.

     <!-- border; size:540px --> ![System registered](./system-registered.png)


For more details about registering an SAP S/4HANA Cloud system, see [Register an SAP S/4HANA Cloud System in a Global Account in SAP BTP](https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/28171b629f3549af8c1d66d7c8de5e18.html) on the SAP Help Portal.


### Set up entitlements for your SAP BTP subaccount

You've connected the SAP S/4HANA Cloud system to SAP BTP (with status **Enabled** in your SAP S/4HANA Cloud tenant). You need to configure entitlements to make this system accessible in the SAP BTP subaccount in which you want to build your extension application. You configure the entitlements and assign the corresponding quota and service plans to the subaccount in which the extension application resides.

1. Enter your **Global Account**.

2. Choose **Entitlements** &rarr; **Entity Assignments**.

3. Select your subaccount from the value help in the **Subaccounts/Directories** field.

5. Choose **Edit** &rarr; **Add Service Plans**.

     <!-- border; size:540px --> ![Edit service plans](./edit-service-plans.png)

6. In the **Subaccount `<your-subaccount-name>`: Add Service Plans** dialog box, select the service **SAP S/4HANA Cloud Extensibility**.

7. In the **Service Details: SAP S/4HANA Cloud Extensibility** screen area, select your newly registered system name from the dropdown help to list the **Available Plans**.

      - **messaging** – to consume SAP S/4HANA Cloud events and create event-based extensions using the event bus from SAP Event Mesh Integration

      - **api-access** – for generic access for SAP S/4HANA Cloud APIs

8. Select **api-access** service plan.

9. Choose **Add 1 Service Plans** to add the service plan of the SAP S/4HANA Cloud Extensibility service.

     <!-- border; size:540px --> ![Add SAP S/4HANA Cloud Extensibility service plan](./add-s4hana-extensibility.png)

10. Choose **Save**.