# Deploy and Run the Application on Cloud Foundry

## Prerequisites

Prepare your sample for deploying on Cloud Foundry: [Prerequisite-for-sample](./1-getting-started-with-ams.md).

## Deploy to Cloud

1. Prepare for production.
```sh
cds add mta,hana,approuter
```

This adds the needed configuration for an SAP HANA database (needs to be provisioned in your account), fur using an approuter, and using MTA as deployment.

<!-- The flow that I'm seeing is, that the mta.yaml ist just being generated. So I'll remove all the mta.yaml editing steps. -->

2. Update `app/incidents/xs-app.json` with the following code:
   ```
      {
      "welcomeFile": "/index.html",
      "authenticationMethod": "route",
      "routes": [
        {
          "source": "^/odata/(.*)$",
          "target": "/odata/$1",
          "destination": "incident-management-srv-api",
          "authenticationType": "ias",
          "csrfProtection": false
        },
        {
          "source": "^/resources/(.*)$",
          "target": "/resources/$1",
          "authenticationType": "none",
          "destination": "ui5"
        },
        {
          "source": "^/test-resources/(.*)$",
          "target": "/test-resources/$1",
          "authenticationType": "none",
          "destination": "ui5"
        },
        {
          "source": "^(.*)$",
          "target": "$1",
          "service": "html5-apps-repo-rt",
          "authenticationType": "ias"
        }
      ]
    }
   ```

   > Change the  `authenticationType ` of `incident-management-srv-api` and `html5-apps-repo-rt` from `xsuaa` to `ias`

   
3. Build the mtar.
    ```
    mbt build
    ```
    
4. Log in to your SAP BTP subaccount and choose your Cloud Foundry space where you want to deploy your application.

    ```
    cf login -a <api-endpoint>
    ```
    
5.  Deploy on Cloud Foundry.

    ```
    cf deploy mta_archive/<mtar_name>.mtar
    ```

After successful deployment, you can go to **SAP BTP Cockpit -> your subaccount and your space** and see your application as well as bound services.

## Check Your IAS Application and Uploaded AMS Policies.

- Log in to your IAS Tenant and go to **Applications & Resources**.
- Search and select your application with `incident-ias-<unique-id>` (in this case its `incident-ias-staging`).
- Check the uploaded dcl policies under **Authorization Policies**.
    ![Alt text](./images/policies.png)<br />
    
- Assign users to your policies.
    ![Alt text](./images/user-assignmrnt.png)<br/>   

## Set Up Application to Application Communication

The application has [app2app navigation](https://help.sap.com/docs/build-work-zone-standard-edition/sap-build-work-zone-standard-edition/switching-to-sap-cloud-identity-services-identity-authentication#app-to-app-navigation) configuration where the CAP back end with IAS-based authentication exposes an API that is configured as a dependency of the SAP Biuld Workzone’s IAS application. The `IASDependencyName` is then defined in the GACD Destination Deployer module configuration.

### Update OpenID Connect Configuration

  - Log in to your SAP Cloud Identity Services admin console.
  - Go to **Applications & Resources**.
  - Search for your application bound to your CAP backend (in this case its `incident-ias-staging`).
  - Go to **Trust -> OpenID Connect Configuration -> Advanced Settings -> Access Token Format**. Choose **JSON Web Token** and **Save**.
  ![](./images/openId%20%20config.png)

### Set Up Communication

  - Log in to your SAP Cloud Identity Services admin console.
  - Go to **Applications & Resources**.
  - Search for your IAS application bound to your CAP backend (in this case it's `incident-ias-staging`).
  - Verify that the endpoint exposed by your application is listed in **Application APIs -> Provided APIs**.
   ![](./images/backend%20ias.png)
  - Search and select your SAP Build Work Zone Workzone application in **SAP Build Work Zone, standard edition -> Application APIs -> Dependencies**. Choose **Add** a dependency.
   ![](./images/workzone%20ias.png)

  - Give the dependency the same name as the one you provided in the `destination service configuration property` in the `mta.yaml`.
    ```
     HTML5.IASDependencyName: incidents-api
    ```
  - For each application, select the IAS application bound to your CAP backend (in this case, it's `incident-ias-staging`).
  - Select the exposed endpoint (in this case, its `incidents-api`), and choose **Save**.
    ![](./images/dependency.png)

## Access Your Application
To access the application in launchpad, proceed to [Integrate with SAP Build Workzone, standard edition](https://developers.sap.com/tutorials/integrate-with-work-zone.html).

