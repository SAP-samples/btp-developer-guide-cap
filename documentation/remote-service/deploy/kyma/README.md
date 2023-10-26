# Option 2 - Deploy and Run the Application on Kyma

If you don't have access to an SAP backend system (SAP ECC, SAP S/4HANA or SAP on-premise system) but still need OData services with some data, you can use this [mock server application](https://github.com/SAP-samples/cloud-extension-ecc-business-process/blob/mock/README.md). It contains some entities of SAP OData services with sample data.

> This installation of the mock server is only needed if you want to test an application deployed on Cloud Foundry. For local development testing, you can use the local mock server. 

Based on the system to which you want to connect, you can choose one of the two options:

   - [Deploy the application using the SAP S/4HANA Cloud system ](./deploy-to-kyma.md)
   - [Deploy the application with mock server - optional](./deploy-app-using-mock-kyma.md)
