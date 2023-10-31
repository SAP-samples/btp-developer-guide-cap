# Setup CI/CD Pipeline

This section describes how to configure and run a predefined continuous integration and delivery (CI/CD) pipeline using SAP Continuous Integration and Delivery service that automatically builds, tests and deploys your code changes to speed up your development and delivery cycles.
For more information, see See [SAP Continuous Integration and Delivery](https://discovery-center.cloud.sap/serviceCatalog/continuous-integration--delivery?region=all).

The steps below guide you through setting up your pipeline.


## Initialize a Repository in VS Code

To be able to perform the steps for setting up a CI/CD pipeline, you need a public repository. Currently, SAP Continuous Integration and Delivery supports **GitHub** and **Bitbucket** repositories.

For real application development, you need to consider the right place for your repository.

In this example, we’ll be creating a repository on GitHub. You need a **GitHub** account for this step.

1. In VS Code, navigate to **Explorer** and choose **Open Folder**. 
![openFolder](./cicd28.png)

2. Open the folder which contains your Incident Management application.

3. Navigate to the project's root folder and create a new file `.gitignore`.

4. Add the following code snippet to it  
    ```
    node_modules/
    package-lock.json
    gen/

    *.mtar
    mta_archives/
    ```
5. If your project already has a .gitignore file, ensure that the following is mentioned in it.

6. Now navigate to **Source Control** and choose **Initialize Repository**.
![initializeRepo](./cicd29.png)

7. Stage all the changes using the **+** icon and provide a relevant commit message. Then click on Commit.
![commit](./cicd30.png)

8. Click **Publish Branch**. 
![publish](./cicd31.png)

    You may be redirected to a browser to authenticate into your GitHub account. Provide your GitHub username and password when prompted. When the changes are pushed, you’ll be able to see your project in your GitHub repository.

<br>

## Setup the Continuous Integration and Delivery Service

1. Enable SAP Continuous Integration and Delivery.
- In SAP BTP Cockpit, go to your subaccount.
- In Service Marketplace, type Continuous into the search box. Continuous Integration and Delivery service appears.
- Choose **Create**.
![Choose create](./cicd1.png)

2. Assign role collection.

- In your SAP BTP subaccount, choose **Security -> Users**.
- Choose the name of your identity provider and navigate into it.
- From the menu, choose **Assign Role Collection**. Search for *CICD Administrator* and add the role to your user.

3. Ensure that you can open and access the application. In the cockpit,  go to **Instances and Subscriptions** to access the **Continuous Integration & Delivery** application.
![cicd-app](./cicd3.png)

    This should navigate you to the main page of the application.
![cicd-mainPage](./cicd4.png)

<br>

**NOTE:**
**If you intend to deploy this application on a cluster that has a deployment of the same application, it is recommended to undeploy this installation via your terminal using the command:**
```
helm uninstall incident-management -n <namespace>
```


## Retrieve Kyma Cluster Configuration Details

In order to run the pipeline using the CI/CD service, you need to create a service account. To do this, follow the steps.

1. First you need to create a namespace. In the SAP BTP Cockpit, open the **Kyma Dashboard** for your subaccount. 

    ![dashboard](./cicd2.png)

    Your dashboard should look like this.
![kyma-dashboard](./cicd5.png)

2. In the left navigation menu, choose **Namespaces** and then **+ Create Namespace**. 
![namespacePage](./cicd6.png)

    Provide any relevant name of your choice e.g: incidents-namespace. Also **Enable Sidecar Injection** and choose **Create**.
![namespaceCreation](./cicd7.png)

4. For this namespace, you need to create a Service Account. This is a non-human account which will authenticate your pipeline to access your cluster. See [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/). 

    Ensure you are in your created namespace. From the left navigation menu, click on the dropdown **Configuration** and navigate to **Service Accounts**. Here click on **+ Create Service Account**.
    ![serviceAccountPage](./cicd8.png)

    Give your service account a name e.g: incidents-namespace-service-account and choose **Create**.
    ![serviceAccountCreation](./cicd9.png)

5. For your pipeline to access your Kyma cluster through this service account, it requires a set of configurations. This is defined in the **KubeConfig** file of the account. 

    To retrieve this, ensure you are on the page of the created service account and choose on **Generate TokenRequest**. 
    ![kubeConfig](./cicd10.png)

    Here you can choose the **Expiration seconds** as desired from the dropdown and choose **Generate**.
    The configuration details should mention a token, your Kyma cluster and namespace.
   
    ![configDetails](./cicd11.png)

    Now choose **Copy** as these details will be needed to create your pipeline credentials as described in the step below. 

7. Navigate to the Continuous Integration and Delivery Application (follow the steps mentioned above). On this page, choose **Credentials** and click on the **\+** to create a new credential. 

    Choose a relevant name for your credential e.g: kube-config. For type, choose **Kubernetes Configuration** from the dropdown. In the **Content space**, paste the KubeConfig file of the service account you copied from the previous step. Choose Create.
    ![credential](./cicd12.png)

8. You need to add your service account to a **Cluster Role Binding**. Go back to your cluster and from the menu, choose **Configurations** and navigate to **Cluster Role Bindings**. Here click on any **admin** role binding.
![binding](./cicd13.png)

    On this page, choose **Edit**.
![edit](./cicd14.png)

    Here choose **Add Subject** and click on the last row (newly created subject). For **User Name**, enter the value in the form `system:serviceaccount:<namespace>:<service-account>`. 
    Choose **Update**. 
![subject](./cicd15.png)

<br>

## Get Docker Credentials
For your pipeline to be able to push and pull images from your docker repository, you need to set your docker credentials for your job. 

1. To run this pipeline you would need your credentials to be base64-encoded. To obtain these credentials, login to your registry from the terminal:
    ```
    docker --config /tmp login docker.io
    ```
    Provide your credentials if prompted.

2. Run the command:
    ```
    cat /tmp/config.json
    ```
    You should see the output below
    ```json
    {
        "auths": {
            "https://index.docker.io/v1/": {}
        },
        "credsStore": "osxkeychain"
    }   
    ```
3. To retrieve the credentials in the desired format, remove the `credsStore` key-value pair.
    ```json
    {
        "auths": {
            "https://index.docker.io/v1/": {}
        }
        ,   // [!code --] 
        "credsStore": "osxkeychain"  // [!code --] 
    }   
    ```
4. Now again run the same login command mentioned in step 1. You need to enter your credentials again. Enter the credentials as shown in step 2. Make sure your credentials are in this form
    ```json
    {
        "auths": {
            "https://index.docker.io/v1/": {
                "auth": "abc...xyz"
            }
        }
    }
    ```
    To these credentials make the following changes
    ```json
    {
        "auths": {
            "index.docker.io": {        // [!code ++] 
                "auth": "abc...xyz"
            }
        }
    }
    ```
2. Now add these docker credentials as a CI/CD credential. Navigate to the Continuous Integration and Delivery Application (follow the steps mentioned above). On this page choose **Credentials** and click on the **\+** to create a new credential. 

    Choose a relevant name for your credential e.g: docker-config. For **Type**, choose **Container Registry Configuration** from the dropdown. In the **Content** space, paste the docker configurations you retrieved from the previous step. Choose **Create**.
![credentials](./cicd16.png)
 
<br>

## Pipeline configuration 
1. In the root folder, create a folder `.pipeline`. Within this folder create a new file `config.yml`.

3. Open the newly created `.pipeline/config.yml` file and paste the following content.
    ```yaml
    general:
      buildTool: "npm"
      chartPath: chart
    service:
      buildToolVersion: "N18"
    stages:
      Build:
        npmExecuteLint: true
      Additional Unit Tests:
        npmExecuteScripts: true
      Acceptance:
        kubernetesDeploy: false
      Compliance:
        sonarExecuteScan: false
      Release:
        kubernetesDeploy: true
        deploymentName: incident-management
        kubeConfigFileCredentialsId: <kube-config-credentials-name>
        namespace: <namespaceName>
        additionalParameters:
        - --set-file
        - xsuaa.jsonParameters=xs-security.json
    steps:
      npmExecuteLint:
        failOnError: true
      npmExecuteScripts:
        runScripts:
        - "test"
      buildExecute:
        npmRunScripts: [ 'cds-build' ]
        npmInstall: false
        cnbBuild: true
        helmExecute: true
      cnbBuild:
        containerRegistryUrl: 'https://index.docker.io'
        dockerConfigJsonCredentialsId: <docker-config-credentials-fileName>
        multipleImages:
        - path: gen/srv
          containerImageName: <your-container-registry>/incident-management-srv
          containerImageAlias: <your-container-registry>/incident-management-srv
          containerImageTag: <srv-image-version>
        - path: gen/db
          containerImageName: <your-container-registry>/incident-management-hana-deployer
          containerImageAlias: <your-container-registry>/incident-management-hana-deployer
          containerImageTag: <hana-deployer-image-version>
        - path: app/incidents
          containerImageName: <your-container-registry>/incident-management-html5-deployer
          containerImageAlias: <your-container-registry>/incident-management-html5-deployer
          containerImageTag: <html5-deployer-image-version>
      helmExecute:
        helmCommand: dependency
        dependency: update
    ```

4. Now you'll need to make changes to the `config.yml` file. In the `Release` stage, change the **kubeConfigFileCredentialsId** and **namespace**.
![release](./cicd17.png)
    The parameter `kubeConfigFileCredentialsId` should have the same value as the name given to your **Kubernetes Configuration** credential. Refer to [Retrieve Kyma cluster configuration details](./README.md#retrieve-kyma-cluster-configuration-details), step 5. 

    The parameter `namespace` should have the same value as the one you created in your Kyma cluster in [Retrieve Kyma cluster configuration details](./README.md#retrieve-kyma-cluster-configuration-details), step 2 .

5. Navigate to the `cnbBuild` step and change the values of **dockerConfigJsonCredentialsId** and the **containerImageName, containerImageAlias and containerImageTag**.
![cnbBuild](./cicd18.png)

    For the parameter `dockerConfigJsonCredentialsId`, it should be the same value as the credential name given for the **Container Registry Configuration** credential created in [Get docker credentials](./README.md#get-docker-credentials), step 5.

    The parameters for the images must be changed with your docker registry name wherever mentioned. The preferred image versions must also be mentioned wherever relevant. 

<br>

## Prepare Your Code

1. Open the `package.json` file and add a script to run `cds build`.
    ```json
    "scripts": {
        "watch": "cds watch",
        "start": "cds-serve",
        "test": "npx jest --silent",
        "cds-build": "npm install --include=dev && cds build --production" // [!code ++] 
    },
    ```
2. Remove the following from the same package.json file
    ```json
    {
        . . . 
        "devDependencies": {
             . . .
            "rimraf": "^3.0.2" // [!code --]
        },
        "scripts": {
            . . .
            "undeploy": "cf undeploy incident-management --delete-services --delete-service-keys --delete-service-brokers", // [!code --]
            "build": "rimraf resources mta_archives && mbt build --mtar archive",   // [!code --]
            "deploy": "cf deploy mta_archives/archive.mtar --retries 1" // [!code --]
        }
        . . .
    }
    ```
3. From the terminal run the following command:
   ```
   npm add -D @sap/cds-dk
   ```
   This will add the devDependency to the same package.json file.
   ```json
    {
        . . . 
        "devDependencies": {
             . . .
            "@sap/cds-dk": "^7.x.x" // [!code ++]
        },
        . . .
    }
    ```

4. Push these changes to your main branch from the **Source Control** by first staging and commiting. 
![pushChanges](./cicd32.png)

<br>

## Create the Pipeline

1. Create a new credential for GitHub:
    - Name: "github"
    - Type: Basic Authentication
    - Username: add your GitHub username/ id
    - Password: enter your GitHub access token 

    Choose **Create**
 ![configure pipeline](./cicd33.png)

2. Go back to the **Jobs** tab and choose **+** icon to create a new job.

3. Under **General Information**, add the following data:

    - Job Name: "incidentManagement"
    - Repository: Click the highlighted button. Then click on **Add Repository**
![configure pipeline](./cicd34.png)
![addRepository](./cicd35.png)

4. Provide the information to your GitHub repository that you had created initially.

    - Name: &lt;add your repo name&gt;
    - Clone URL: &lt;add your repo-URL&gt;
    - Credentials: &lt;add the credentials that you created in step 1.&gt;
    - Type: GitHub
![configure pipeline](./cicd25.png)

5. Back in the **Add Repository** screen, choose **Add** to finish.

6. In the **General Information** tab, continue configuring the Job:
 
  - Branch: master
  - Pipeline: Kyma Runtime
 ![configure pipeline](./cicd20.png)

7. In **Stages**, choose **Source Repository** as your **Configuration Mode** from the dropdown. 
 ![sourceRepo](./cicd21.png)

<br>

## Run the Pipeline and See Your deployment

1. Now you can test your job manually for the first time after creation. Go back to the **SAP Continuous Integration and Delivery** application and navigate to the **Job** tab.

2. Choose the name of your created job and choose **Run**
![configure pipeline](./cicd22.png)

3. You can monitor your pipeline through the logs of the different stages.
![logs](./cicd23.png)

4. The outcome of installation will look something like this in the **Release** stage.
![deploy](./cicd24.png)
<br>

5. To be able to access the application, [Assign Application Roles](../assign-application-roles/assign-application-roles.md).

6. To access the application in launchpad from SAP Build Work Zone, proceed to [Integrate with SAP Build Work Zone](https://developers.sap.com/tutorials/integrate-with-work-zone..html).
