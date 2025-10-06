# Add Dependencies for SAP Cloud SDK for AI 

## Add and Install Required Packages

1. Open the package.json file and add the following dependencies:

```json
"dependencies": {
    ...
    "@sap-ai-sdk/foundation-models": "^1.12.0",
    "@sap-ai-sdk/langchain": "^1.12.0",
    "csv-parser": "^3.2.0",
    "fs": "^0.0.1-security",
    "natural": "^8.0.1"
},
```

> [!Note]
> You need these packages to consume AI services in the CAP application.

2. From the root of the project, choose the hamburger menu, and then choose **Terminal** → **New Terminal**.

    ![prereq](../images/extend-service/open-terminal.png) 

3. Run `npm install` to install the required dependencies.

## Log in to SAP BTP, Cloud Foundry Runtime

1. In the terminal, log in to your subaccount in SAP BTP by following the following commands:

```sh
cf api <API-ENDPOINT>
cf login --sso
```

> [!Note]
> You can find the API endpoint in the **Overview** section of your subaccount in the SAP BTP cockpit.
![prereq](../images/prereq/retrieve_endpoint.png) 

2. Copy the URL to get the **Temporary Authentication Code** and paste it in the new tab.

    ![prereq](../images/extend-service/get-temp-code.png)

3. Find the **Enter the origin key** text box and choose **Sign in with an alternative identity provider**.

    > Note: Ask the instructor for the origin key

    ![deploy-cf](../images/prereq/tenant_login.png)

    > Note: When choosing **Sign-in with an alternative identity provider**, if you are prompted to sign in, enter your username and password.
    > If you are signed in with **Default Identity**, you can choose to sign in with the default identity provider.

4. Choose the **Copy** icon to get a temporary authentication code.

    ![deploy-cf](../images/prereq/deploy_auth_code.png)

5. Paste the copied code in the terminal and click **Enter**.

6. Select the relevant org and click **Enter**.

7. Select the created space and click **Enter**.

## Set Up Initial Data for Incident Management Application

1. Open the `schema.cds` file and add the following code snippets:

    1. Under `Incidents` entity, add the `solutions`.

        ```sh
        solutions    : Composition of many {
            key ID    : UUID;
            confidence : String;
            solution   : String;
        };
        ```

    2. Add a new entity called `vectorEmbeddings`.

        ```sh
        entity vectorEmbeddings : cuid, managed{
            metadata   : LargeString;
            text_chunk : LargeString;
            embedding  : Vector(1536);
            solution   : LargeString;
        }
        ```

2. The sample data generated in the previous steps, creates the **data** folder in the **test** folder. To use the data for productive usage, move the **data** folder to the **db** folder. Open the terminal, and run the following command to move the CSV files.

    ```sh
    mv test/data db/data
    ```

3. Run the productive build for your application:

    ```sh
    cds build --production
    ```

4. Deploy the csv files to the SAP HANA database:

    ```sh
    cds deploy --to hana
    ```
 
    > [!Note]
    > It might take a few seconds to finish the deployment to SAP HANA. Once done, you get the successful deployment message.
    ![success](../images/extend-service/successful-deployment.png)

## Create Service Binding to SAP Destination Service

1. Create the instance and binding by running the following commands in the terminal.

```sh
cf create-service destination lite <destination-name>
cds bind --to <destination-name>
```

## Next Step

[Extend the Incident Management Application](extend-service.md)
