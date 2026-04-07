---
title: Introduction to Remote Service Connectivity
description: Learn how to extend the functionality of the Incident Management sample application.
parser: v2
auto_validation: true
time: 10
tags: [ tutorial>intermediate, software-product-function>sap-cloud-application-programming-model, programming-tool>node-js, software-product>sap-business-technology-platform]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Svetoslav Pandeliev
author_profile: https://github.com/slavipande
---

## You will learn

- How to extend the functionality of the Incident Management sample application.
- How to integrate the SAP S/4HANA Cloud Business Partner API to the Incident Management application.

## Prerequisites

- You've set up the Incident Management sample application. You can choose from two alternative options:
    - Follow the tutorials in the [Develop a Full-Stack CAP Application Following SAP BTP Developer’s Guide](https://developers.sap.com/group.cap-application-full-stack.html) group to develop the application from the start. 
    - Go to the Incident Management application GitHub repository directly and clone the application without going through the application development steps. See [Incident Management](https://github.com/cap-js/incidents-app/tree/beginner-tutorials).
- You've deployed the Incident Management sample application in the SAP BTP, Cloud Foundry runtime or in the SAP BTP, Kyma runtime. To deploy the Incident Management sample application in the SAP BTP, Cloud Foundry runtime, follow the tutorials in the [Deploy a Full-Stack CAP Application in SAP BTP, Cloud Foundry Runtime Following SAP BTP Developer’s Guide](https://developers.sap.com/group.deploy-full-stack-cap-application.html) group of tutorials. To deploy the Incident Management sample application in the SAP BTP, Kyma runtime, follow the tutorials in the [Deploy a Full-Stack CAP Application in SAP BTP, Kyma Runtime Following SAP BTP Developer’s Guide](https://developers.sap.com/group.deploy-full-stack-cap-kyma-runtime.html) group of tutorials.

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Overview

In this tutorial, you integrate the SAP S/4HANA Cloud Business Partner API to the Incident Management application.

The Incident Management application helps support representatives process and manage customer incidents. A support representative (processor) receives a phone call from an existing customer and creates a new incident on behalf of the customer.

When the processor creates a new incident, they have to assign the incident to the respective customer. The value help of the **Customer** field provides the option to choose a customer from a list of customers. The Incident Management application fetches the list of customers from the SAP S/4HANA Cloud system. For this purpose, you use the SAP S/4HANA Business Partner API.

<!-- border; size:540px --> ![Solution diagram](tutorials/remote-service-intro/Solution-Diagram-RS.png)

### Benefit from a sample application

There's a sample application called Incident Management that you can test and play with. First, you go through the [Develop a Full-Stack CAP Application Following SAP BTP Developer’s Guide](https://developers.sap.com/group.cap-application-full-stack.html) group of tutorials based on the Incident Management application step by step and explore the source code and the configuration tasks.

Alternatively, you can go to the Incident Management application GitHub repository directly and clone the application without going through the application development steps. See [Incident Management](https://github.com/cap-js/incidents-app/tree/beginner-tutorials).

Then, you go through the following tutorials to extend the Incident Management application.

### SAP Cloud Application Programming Model (CAP)

CAP is a framework of languages, libraries, and tools for building enterprise-grade services and applications. It guides developers along proven best practices and a great wealth of out-of-the-box solutions to recurring tasks.

Instead of delving into overly technical disciplines, CAP lets you focus on your domain. This approach accelerates the development process and safeguards investments in a world of rapidly changing cloud technologies.

The CAP framework features a mix of proven and broadly adopted open-source and SAP technologies, as highlighted in the following figure.

![CAP Overview](cap_overview.png)

On top of open-source technologies, CAP adds:

- Core Data Services (CDS) as a universal modeling language for both domain models and service definitions.
- A Service SDK and runtime for Node.js and Java, offering libraries to implement and consume services as well as optimized generic provider implementations, which are capable of automatically serving many requests.

### SAP Business Technology Platform (SAP BTP)

SAP BTP is an integrated offering comprised of four technology portfolios: database and data management, application development and integration, analytics, and intelligent technologies. SAP BTP is built on a multi-cloud foundation, which lets you choose from different infrastructures and runtimes. SAP BTP is multilingual, with support for most major languages and support for development, testing, and production systems both inside an organization and to the larger public.

SAP BTP is also constantly evolving. SAP continuously updates the services that it provides, the platforms that run the custom code, and the infrastructure. This maintenance allows developers to focus on the custom code, and not to worry about hardware maintenance or software upgrades. SAP BTP offers you the ability to turn data into business value, compose end-to-end business processes, and build and extend SAP solutions and applications quickly.

The central point of entry to the platform is the SAP BTP cockpit, where you can access your accounts and applications and manage all activities associated with them.

### SAP BTP, Cloud Foundry runtime and SAP BTP, Kyma runtime

The structure of the account in SAP BTP provides a flexible and scalable way to organize and manage resources. Open-source cloud computing platforms like Cloud Foundry and Kyma offer developers a way to deploy and manage cloud applications with ease.

### Using free service plans

Some services used in these tutorials that are part of the free tier model for SAP BTP. The free tier model lets you try out services in global accounts without any additional cost using the consumption-based commercial model and an [enterprise account](https://help.sap.com/docs/btp/sap-business-technology-platform/enterprise-accounts).

The free tier model includes free service plans limited in scope and capacity for many services within SAP BTP. To learn more about and how to access free service plans, see [Using Free Service Plans](https://help.sap.com/docs/btp/sap-business-technology-platform/using-free-service-plans).

Services that aren't part of the free tier model for SAP BTP use the regular service plans.
