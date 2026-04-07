---
title: Introduction to Application Development Using CAP
description: Learn about SAP Cloud Application Programming Model (CAP) and application development on SAP Business Technology Platform (BTP).
parser: v2
auto_validation: true
time: 7
tags: [ tutorial>beginner, programming-tool>sapui5, software-product>sap-business-technology-platform, software-product>sap-fiori, software-product-function>sap-cloud-application-programming-model]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Svetoslav Pandeliev
author_profile: https://github.com/slavipande
---

## You will learn

- How to develop and deploy a full-stack application based on the SAP Cloud Application Programming Model (CAP).
- How to use SAP Business Application Studio.
- How to follow best practices to improve the process of implementing a business application on SAP BTP.

## Prerequisites

There are no prerequisites for this tutorial.

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Overview

Welcome to your guide to application development on the SAP Business Technology Platform (SAP BTP). This page is the introduction followed by comprehensive tutorials that guide you through the process of developing and deploying a full-stack application based on the [SAP Cloud Application Programming Model (CAP)](https://cap.cloud.sap/docs/) and [SAP Fiori elements](https://sapui5.hana.ondemand.com/sdk/#/topic/03265b0408e2432c9571d6b3feb6b1fd) on [SAP BTP](https://developers.sap.com/tutorials/cp-explore-cloud-platform.html). With these tutorials, you leverage a variety of different tools and services, learning each of them step by step. Whether you're new to SAP BTP or an experienced developer, the following tutorials are designed to help you hit the ground running.

This guidance covers a variety of topics starting from basic onboarding tasks to creating development pipelines. The tasks are bundled in step-by-step tutorials featuring the following topics:

- Setting up SAP Business Application Studio as your development environment
- Developing a CAP application including user interface
- Implementing authorization checks
- Creating a subaccount in SAP BTP
- Deploying in SAP BTP

<!-- border; size:540px --> ![Solution diagram](solution-diagram.png)

### Benefit from a sample application

There's a sample application called Incident Management that you can test and play with. Go through the following tutorials based on the Incident Management application step by step and explore the source code and the configuration tasks.

### SAP Cloud Application Programming Model (CAP)

CAP is a framework of languages, libraries, and tools for building enterprise-grade services and applications. It guides developers along proven best practices and a great wealth of out-of-the-box solutions to recurring tasks.

Instead of delving into overly technical disciplines, CAP lets you focus on your domain. Focusing on your domain accelerates the development process and safeguards investments in a world of rapidly changing cloud technologies.

The CAP framework features a mix of proven and broadly adopted open-source and SAP technologies, as highlighted in the following figure.

![CAP Overview](cap_overview.png)

On top of open-source technologies, CAP adds:

- Core Data Services (CDS) as a universal modeling language for both domain models and service definitions.

- A Service SDK and runtime for Node.js and Java, offering libraries to implement and consume services as well as optimized generic provider implementations, which are capable of automatically serving many requests.

### SAP Business Technology Platform (SAP BTP)

SAP BTP is an integrated offering comprised of four technology portfolios: database and data management, application development and integration, analytics, and intelligent technologies. SAP BTP is built on a multi-cloud foundation, which lets you choose from different infrastructures and runtimes. SAP BTP is multilingual, with support for most major languages and support for development, testing, and production systems both inside an organization and to the larger public.

SAP BTP is also constantly evolving. SAP continuously updates the services that it provides, the platforms that run the custom code, and the infrastructure. This maintenance allows developers to focus on the custom code, and not to worry about hardware maintenance or software upgrades. SAP BTP offers you the ability to turn data into business value, compose end-to-end business processes, and build and extend SAP solutions and applications quickly.

The central point of entry to the platform is the SAP BTP cockpit, where you can access your accounts and applications and manage all activities associated with them.

### SAP BTP, Cloud Foundry Runtime and SAP BTP, Kyma Runtime

The structure of the account in SAP BTP provides a flexible and scalable way to organize and manage resources. Open-source cloud computing platforms like Cloud Foundry and Kyma offer developers a way to deploy and manage cloud applications with ease.

<!--
These tutorials provide instructions for deploying your CAP application to both SAP BTP, Cloud Foundry runtime and SAP BTP, Kyma runtime.

For a thorough comparison and analysis of differences between the Cloud Foundry runtime and the Kyma runtime, see:

- [A Beginner’s Journey to Cloud Computing: SAP BTP, Cloud Foundry and Kyma Demystified](https://blogs.sap.com/2023/03/03/a-beginners-journey-to-cloud-computing-sap-btp-cloud-foundry-and-kyma-demystified./)
- [Developing an Application on SAP BTP Cloud Foundry Runtime and SAP BTP Kyma Runtime: A Comparative Analysis](https://blogs.sap.com/2023/04/28/developing-an-application-on-sap-cloud-foundry-runtime-and-sap-kyma-runtime-a-comparative-analysis/)
-->

### Using Free Service Plans

All services needed for the execution of the tutorials are part of the free tier model for SAP BTP. The free tier model lets you try out services in global accounts without any additional cost using the consumption-based commercial model and an [enterprise account](https://help.sap.com/docs/btp/sap-business-technology-platform/enterprise-accounts).

The free tier model includes free service plans limited in scope and capacity for many services within SAP BTP. To learn more about and how to access free service plans, see [Using Free Service Plans](https://help.sap.com/docs/btp/sap-business-technology-platform/using-free-service-plans).
