# Simplifying App Development with SAP Build Code powered by SAP Joule AI
In this hands-on exercise you would learn how to jumpstart your application development of a full stack SAP Cloud Application Programming Model (CAP) based application using SAP Build Code powered by SAP Joule AI


## Key Capabilities of SAP Build Code. 
- Enable developers to code faster and smarter, generate code from natural language descriptions using generative AI
- Build extension applications, and integrate them with SAP and non-SAP systems
- Use the centralized Lobby for fusion development

## SAP Build code powered by SAP Joule AI

SAP Build Code offers an AI-powered cloud development environment specifically tailored for SAP Cloud Application Programming Model (CAP), SAP Fiori, mobile, and SAPUI5 developers.

By seamlessly integrating coding, testing, and application management, it streamlines the application development process on SAP BTP. SAP Build Code combines SAP Business Application Studio with the most essential services and SDKs on SAP BTP.

With the integration of Joule, the innovative AI copilot of SAP, SAP Build Code enables automatic generation of application code, data models, services, and sample data. Using SAP Build Code ensures adherence to the best practices and guidance outlined in the SAP BTP Developer's Guide.

![build code with joule](images/build-code.png)


## Business Scenario

In this hands-on exercise you would build an Incident Management application using SAP Build Code. The business scenario of Incident Management Applciation is as follows:

ACME is a popular Electronics company. ACME hires call center support representatives to process and manage customer incidents. A call center support representative (Processor) receives a phone call from an existing customer and creates a new incident on behalf of the customer. The newly created incident is based on a customer complaint received during the phone call. The call center support representative also adds the conversation with the customer to the incident for future reference.

## Solution Diagram

![Solution Diagram](images/Solution-Diagram.png)


## Hands on Exercise: Develop Basic Incident Management Application using SAP Build Code

1. [Create full stack application](./document/create-full-stack-project.md)
2. [Create data entities](./document/create-data-entities.md)
3. [Enhance sample data](./document/enhance-sample-data.md)
4. [Generate services](./document/generate-service.md)
5. [Create Backend Logic with Joule](./document/custom-logic.md)
6. [Create Fiori UI using Joule](./document/fiori-ui.md)
7. [Deployment to Cloud Foundry Runtime](./document/deploy-cf.md)
8. [End to End testing](./document/e2e-testing.md)