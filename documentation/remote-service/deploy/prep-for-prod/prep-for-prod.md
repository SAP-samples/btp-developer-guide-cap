# Prepare the Project for Production

## Usage scenario

For using the SAP S/4HANA Cloud Extensibilty service to access the Business Partner API you need some additional configurations.


## Prerequisites

You setup the connectiion to an [SAP S/4HANA Cloud system](../../s4hana-cloud-to-btp-connectivity/README.md). 

> By using a mock server you can skip this exercise. 

## Content

1. Create a new file bupa.json at the root folder of the project and copy the below content

- As **systemName** you must enter the name of your the registered SAP S/4HANA Cloud system. 
- As **communicationArrangementName** you must enter a speaking name for your communication arrangement (e.g. INCIDENT_MANAGEMENT_0008).


    ```json
    {
        "systemName": "<SYSTEM_NAME>",
        "communicationArrangement": {
            "communicationArrangementName": "<COMM_NAME>",
            "scenarioId": "SAP_COM_0008",
            "inboundAuthentication": "BasicAuthentication",
            "outboundAuthentication": "BasicAuthentication",
            "outboundServices": [
                {
                    "name": "Replicate Customers from S/4 System to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Replicate Suppliers from S/4 System to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Replicate Company Addresses from S/4 System to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Replicate Workplace Addresses from S/4 System to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Replicate Personal Addresses from S/4 System to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Business Partner - Replicate from SAP S/4HANA Cloud to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Business Partner Relationship - Replicate from SAP S/4HANA Cloud to Client",
                    "isServiceActive": false
                },
                {
                    "name": "Business Partner - Send Confirmation from SAP S/4HANA Cloud to Client",
                    "isServiceActive": false
                },
                {
                    "name": "BP Relationship - Send Confirmation from SAP S/4HANA Cloud to Client",
                    "isServiceActive": false
                }
            ],
            "communicationSystem": {
                "communicationSystemHostname": "default.com",
                "outboundCommunicationUser": {
                    "username": "DefaultUser",
                    "password": "DefaultPassword"
                }
            }
        }
    }
    ```

For more information, [see SAP Help](https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/553a4c6b98be4c1ba7d1dfa0e9df8669.html)

2.  Navigate to the package.json file in the root folder of the application. Replace the settings for **API_BUSINESS_PARTNER** with the following code snippet:
    ```json
    "API_BUSINESS_PARTNER": {
        "kind": "odata-v2",
        "model": "srv/external/API_BUSINESS_PARTNER",
        "[production]": {
            "credentials": {
                "destination": "<DESTINATION_NAME>",
                "path": "/sap/opu/odata/sap/API_BUSINESS_PARTNER"
            }
        }
    }
    ```
> If you deploy to Cloud Foundry then the **destination** would be `incidents-api-access` for Kyma it's `incident-management-s4-hana-cloud`. 