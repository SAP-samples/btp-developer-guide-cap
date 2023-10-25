# Manage Your Application for Event Handling in SAP S/4HANA Cloud System

## Introduction

You need to enable the events that are to be sent from your SAP S/4HANA Cloud system to SAP Business Technology Platform. For this enablement step, go to your SAP S/4HANA system.

## Content

1. Log onto your SAP S/4HANA Cloud system

2. Search for **Enterprise Event Enablement - Configure Channel Binding** and choose the name to open the applicaton

 ![Event Enablement](../images/channelbinding1.png)

3. Choose **Go** to refresh the content

 ![Event Enablement](../images/channelbinding2.png)

4. In the Channel list select your event

> Hint: Look for your emClientId that you had provided in an earlier step. 

 ![Event Channel](../images/channelbinding3.png)

5. Find entry **Outbound Topics** and choose **Create**

 ![Outbound Topic](../images/channelbinding4.png)

6. Choose the topic selector to open a popup to select topics

7. Enter \*BusinessPartner\* into the topic filter

8. Choose **Go**

9. Select **sap/s4/beh/businesspartner/v1/BusinessPartner/***

 ![Business Partner](../images/channelbinding5.png)

10. Choose **Create**.

 ![Business Partner](../images/channelbinding6.png)