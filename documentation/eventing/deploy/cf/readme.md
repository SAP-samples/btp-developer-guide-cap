# Option 1 - Deploy and Run the Application on Cloud Foundry

If you don't have access to an SAP S/4 HANA system but still need oData services with some data to test your eventing implementation, you can use this [mock server application](https://github.com/SAP-samples/cloud-extension-ecc-business-process/blob/mock/README.md). It contains some mocked entities from SAP S/4 HANA oData services with sample data.

> This installation of the mock server is only needed if you want to test an application deployed for Cloud Foundry. For running local developement test you could use the local mock server. 

Based on the system(S/4HANA Cloud or Mock) to which you want to connect to, you can choose one of the below two options

Option A - Follow the below tutorials to Deploy the application using the SAP S/4HANA Cloud system
   - [Prepare for Production](../../develop/prep-for-prod.md)
   - [Deploy the application using the SAP S/4HANA Cloud system ](./deploy-to-cf.md)

Option B - Follow the below tutorials to Deploy the application using Mock Server
   - [Deploy the Application with Mock Server - optional](./deploy-to-cf-mock.md)
   - [Install Mock Server in SAP BTP Cloud Foundry Runtime](./install-mock-server-cf.md)