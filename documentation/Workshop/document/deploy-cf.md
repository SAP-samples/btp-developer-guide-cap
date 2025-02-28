# Deployment to CF

This section describes how to deploy to Cloud Foundry Runtime environment.

## Prerequisites

1. Create UI application via Joule prompt using [Create Fiori UI with Joule](./fiori-ui.md)

2. The sample data generated in the previous steps, creates data folder under test. For deployment, copy the data folder to db. Open the terminal, and run the below command to copy the csv files.

    ```sh
    cp -r test/data db/data
    ```

## Deployment

The final step in SAP Build Code is to deploy the application to CloudFoundry. This process also involves the automatic creation of destinations, enabling ODATA services to be utilised by other tools such as SAP Build Apps.

1. For the deployment go to Task explorer and select the run option next to Enable Discovery and Deploy

    ![deploy-cf](../images/deploy-cf/deploy_cf_enable.png)

2. Check if the task has launched in the terminal

    ![deploy-cf](../images/deploy-cf/deploy_cf_terminal.png)

3. During the deployment, a new page pops up for Cloud Foundry Sign in. Follow the below steps

    - For **Enter Cloud Foundry Endpoint** give ```https://api.cf.ap10.hana.ondemand.com```

    - Let the authentication method be SSO Passcode.

        ![deploy-cf](../images/deploy-cf/signin.png)

    - Click on **Open a new browser page to generate your SSO passcode** to login to the CF subaccount, which opens in a new browser.

    - For sign in with alternative identity provider, find the text box for **Enter the origin key**, and enter **aviss4yru-platform**, and click on **Sign in with alternative identity provider**.

        ![deploy-cf](../images/deploy-cf/tenant_login.png)

        > Note: On Clicking **Sign in with alternative identity provider**, if it asks for sign in, please enter the username and password.

    - Click on copy icon to get the Temporary Authentication Code.

        ![deploy-cf](../images/deploy-cf/deploy_auth_code.png)
    
    - Paste the copied code under **Enter your SSO Passcode** field in Cloud Foundry Sign In page.

    - Click on **Sign in**.

        ![deploy-cf](../images/deploy-cf/deploy_sign_in.png)

4. Under Cloud Foundry Target, do the following:

    - Under **Select Cloud Foundry Organization**, select the org name as **Handson-session***.

    - Under **Select Cloud Foundry Space**, select **dev** space. 

    - Click on Apply.

        ![deploy-cf](../images/deploy-cf/cf_targets.png)

5. Check the terminal for the progress of the deployment. 

6. Once the deployment is completed, the application started log and project Overview URL will be visible.

    ![deploy-cf](../images/deploy-cf/deploy_completed.png)


## Assign the User Roles

### Create a role collection and add role

1. Open the SAP BTP cockpit and navigate to your subaccount.

2. Choose **Security** -> **Role Collections**.

    ![deploy-cf](../images/deploy-cf/role_create.png)

3. In the Search box, type your project name. For example, project name is **Incidentsjd12**, and click on incidentsjd12-Support-dev.

    ![deploy-cf](../images/deploy-cf/select_support_role.png)

4. Click on Edit.

    > Make sure the Support role is already listed under Roles tab.

    ![deploy-cf](../images/deploy-cf/check_support.png)

5. Under Users, do the following:

    - Type the username in the ID field, for example, type as `sapeventuser` and select your username from the suggestions.

    - Select **aviss4yru.accounts.ondemand.com (application users)** from the Identity Provider dropdown.

    ![deploy-cf](../images/deploy-cf/add_user.png)

6. Click on **Save**.

## Next Steps

Test the end to end flow by following [end-to-end-testing](e2e-testing.md)