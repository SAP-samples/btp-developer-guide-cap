# Install Mock Server

## Usage Scenario

If you don't have access to an SAP backend system (ECC, SAP S/4HANA or SAP on-premise system) but still need OData services with some data, you can use this [mock server application](https://github.com/SAP-samples/cloud-extension-ecc-business-process/blob/mock/README.md). It contains some entities of SAP OData services with sample data.

> This installation of the mock server is only needed if you want to test an application deployed for cloud foundry. For running local developement test you could use the local mock server. 

Based on the chosen SAP BTP runtime, you can choose one of the below two options

   - [Option 1. Install the Mock Server in SAP BTP Cloud Foundry Runtime](./install-mock-server-cf.md) 
   - [Option 2. Install the Mock Server in SAP BTP Kyma Runtime](./install-mock-server-kyma.md)