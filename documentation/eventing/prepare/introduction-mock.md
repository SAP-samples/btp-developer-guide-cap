# Introduction
To create event-based extensions using mock server you need to set up the messaging between the mock server and the [SAP Event Mesh](https://discovery-center.cloud.sap/serviceCatalog/event-mesh?region=all). To do so, you need to build eventing logic in mock server and deploy it on SAP BTP.

# Business Scenario

This tutorial shows you how to configure your CAP service to listen for upcoming events and deploy it to the SAP BTP. CAP offers native support for both emitting and receiving events, enabling CAP applications to effectively receive event notifications concerning changes in remote systems.

# Solution Diagram

![Solution-Diagram](./Solution-Diagram.png)