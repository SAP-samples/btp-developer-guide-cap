# Deploy and Run the application on SAP BTP, Cloud Foundry

## Introduction

The SAP BTP, Cloud Foundry environment allows you to create polyglot cloud applications in Cloud Foundry. It contains the SAP BTP, Cloud Foundry runtime, which is based on the open-source application platform managed by the Cloud Foundry Foundation.

The SAP BTP, Cloud Foundry environment enables you to develop new business applications and business services, supporting multiple runtimes, programming languages, libraries, and services.

For more information about the Cloud Foundry environment, see [Cloud Foundry Environment](https://help.sap.com/docs/btp/sap-business-technology-platform/cloud-foundry-environment).

## Prerequisites

* You have prepared the project for productive usage.

## Using MTA

The tool will deploy the modules and services in the deployment descriptor file **mta.yaml**.

You’ll deploy your app with the [Cloud MTA Build Tool](https://sap.github.io/cloud-mta-build-tool/). The tool will deploy the modules and services in the deployment descriptor file **mta.yaml**.

If you don't have the `mta.yaml` file in the project already then run the following command to generate it:

```shell
cds add mta
```
### Configuration Updates

**Changes that need to be made in the mta.yaml**

The following snippet needs to be added at modules->- name: incident-management-app-deployer->build-parameters->requires

```yaml
- name: incidentmanagementmanager
  artifacts:
    - manager.zip
  target-path: resources/
```

> [!TIP]
> **Note 2:** In `manifest.json` (`dataSources -> mainService`), change:

```json
"url": "/odata/v4/manager/"
```

to

```json
"url": "odata/v4/manager/"
```
<details>
<summary><strong>Important: manager.zip not getting generated</strong></summary>

After deployment, if the UI application is missing, it may be because `manager.zip` was not generated during the UI5 build, causing the HTML5 module to be skipped.

This issue may not occur consistently and has been observed intermittently.

#### Troubleshooting

Update the `build` script in `app/manager/package.json`:

```json
"scripts": {
  "deploy-config": "npx -p @sap/ux-ui5-tooling fiori add deploy-config cf",
  "build": "ui5 build preload --clean-dest && cd dist && zip -r manager.zip .",
  "start": "ui5 serve"
}
```
#### Explanation

- UI5 build does not generate a zip file by default
- MTA deployer requires `manager.zip` for HTML5 application deployment
- This step ensures the zip is always created inside the `dist/` folder

</details>


## Assemble with the Cloud MTA Build Tool

Run the following command to assemble everything into a single **mta.tar** archive:

```shell
mbt build
```

See [Multitarget Applications in the Cloud Foundry Environment](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/d04fc0e2ad894545aebfd7126384307c.html?locale=en-US) to learn more about MTA-based deployment.

## Deploy to the SAP BTP, Cloud Foundry runtime

1. From the root of the **INCIDENT-MANAGEMENT** project, choose the burger menu, and then choose **Terminal** &rarr; **New Terminal**.

2. Log in to your subaccount in SAP BTP:

    ```shell
    cf api <API-ENDPOINT>
    cf login
    cf target -o <ORG> -s <SPACE>
    ```

    > You can find the API endpoint in the **Overview** section of your subaccount in the SAP BTP cockpit.

3. Run the following command to deploy the generated archive:

    ```shell
    cf deploy mta_archives/incident-management_1.0.0.mtar 
    ```

4. Check if all services have been created:

    ```shell
    cf services
    ```

    You should see the following services in your space:

    ![Services after deploy](./images/cf-services.png)

5. Check if the apps are running:

    ```shell
    cf apps
    ```

    ![App after deploy](./images/cf-apps.png)


