# Option 2 - Deploy Incident Management Application to Kyma

If you don't have access to an SAP backend system (ECC, SAP S/4HANA or SAP on-premise system) but still need OData services with some data, you can use this [mock server application](https://github.com/SAP-samples/cloud-extension-ecc-business-process/blob/mock/README.md). It contains some entities of SAP OData services with sample data.

> This installation of the mock server is only needed if you want to test an application deployed for Kyma. For running local developement test you could use the local mock server. 

Based on the system to which you want to connect to, you can choose one of the below two options

Option A - Follow the below tutorials to Deploy the application using the SAP S/4HANA Cloud system
   - [Deploy the application using the SAP S/4HANA Cloud system ](./deploy-app-to-kyma.md)

Option B - Follow the below tutorials to Deploy the application using Mock Server
   - [Run the Incident Management Application with Mock Server](./deploy-app-to-kyma.md)
   - [Install Mock Server in SAP BTP Kyma Runtime](./install-mock-server-kyma.md)
   