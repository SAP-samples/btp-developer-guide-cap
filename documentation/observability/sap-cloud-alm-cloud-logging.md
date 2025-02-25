# SAP Cloud ALM 
SAP Cloud ALM is a cloud-based application lifecycle management offering that allows you to implement and operate intelligent cloud business solutions.

You benefit from a native cloud solution, designed as the central entry point to manage your SAP landscape with content-driven implementation and automated operations.

SAP Cloud ALM is included in SAP Enterprise Support/Product Support for Large Enterprises contracts and in SAP Cloud Service subscriptions containing Enterprise Support, cloud edition. 

## SAP Cloud ALM  and SAP Cloud Logging
[SAP Cloud ALM](https://support.sap.com/en/alm/sap-cloud-alm.html?anchorId=section_copy), and [SAP Cloud Logging](https://help.sap.com/docs/application-logging-service?locale=en-US&state=PRODUCTION&version=Validation) can work together to ensure centralized access control, logging, monitoring, and analysis of SAP applications and services running in the cloud environment.


## Scope 
In this section, you'll see how to connect a CAP application to your Cloud ALM tenant in order to get Real User Monitoring and Health Monitoring insights.

### Real User Monitoring
The purpose of Real User Monitoring is to provide transparency about the usage (executions) and the performance (response times) of user interactions. It supports the monitoring of request executions from different platforms with a unified user experience using a common look-and-feel and handling pattern. 

The basic concept is to get all user interactions and the relevant server requests that are correlated in the Real User Monitoring application. Request executions are rated based on historical values and not based on fixed thresholds.

Real User Monitoring helps IT users and business users understand how often applications are executed and what are the response times for the users. 
[See Real User Monitoring](https://support.sap.com/en/alm/sap-cloud-alm/operations/expert-portal/real-user-monitoring.html) for more details. 

### Health Monitoring
In the Health Monitoring application, you can check the health of your monitored cloud service and technical systems from an application and customer perspective. Technical metrics are collected regularly and can be used to calculate the overall health of the monitored object. The monitored metrics are defined by the service itself and may differ for each service type. See [Health Monitoring](https://support.sap.com/en/alm/sap-cloud-alm/operations/expert-portal/health-monitoring.html) for more details.

### Integration & Exception Monitoring
The purpose of Integration & Exception Monitoring is to provide transparency for the data exchange processes. It supports the monitoring for peer-to-peer interfaces as well as interfaces using orchestration platforms and provides a unified user experience for all interface types using a common look-and-feel and handling pattern. 

Integration & Exception Monitoring closes the gap between IT and Business. The correlation of integration artifacts provides end-to-end visibility in interface calls and message flows cross all involved cloud services and systems.

Users of Integration & Exception Monitoring can analyze the actual processing of interface calls and message flows including possible technical or business-driven root causes.

Integration & Exception Monitoring provides the following functionalities:

- Message Monitoring
- Message Search (Tracking)
- Alerting on failed messages or exceptions

## Next Steps
- [Set Up Data Collection for SAP Cloud ALM in a CAP Application](./enable-sap-cloud-alm.md)
