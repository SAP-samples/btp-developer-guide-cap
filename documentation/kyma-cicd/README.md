# Setup CI/CD Pipeline

This section describes how to configure and run a predefined continuous integration and delivery (CI/CD) pipeline using [SAP Continuous Integration and Delivery](https://discovery-center.cloud.sap/serviceCatalog/continuous-integration--delivery?region=all) service that automatically builds, tests and deploys your code changes to speed up your development and delivery cycles.

The steps below will guide your through setting up your pipeline.


## Initialize a repository in VSCode

To be able to perform the steps for setting up a CI/CD pipeline, you will need a public repository. Currently, SAP Continuous Integration and Delivery supports **GitHub** and **Bitbucket** repositories.

For real application development, you need to consider the right place for your repository.

In this example, we’ll be creating a repository on GitHub. You’ll need a **GitHub** account for this step.

1. In VSCode, navigate to **Explorer** and choose **Open Folder**. 
![openFolder](./cicd28.png)

2. Open the folder which contains your incident-management application.

3. Now navigate to **Source Control** and choose **Initialize Repository**.
![initializeRepo](./cicd29.png)

4. Stage all the changes using the **+** icon and provide a relevant commit message. Then click on Commit.
![commit](./cicd30.png)

5. Click **Publish Branch**. 
![publish](./cicd31.png)

    You may be redirected to a browser to authenticate into your GitHub account. Provide your GitHub username and password when prompted. When the changes are pushed, you’ll be able to see your project in your GitHub repository.

<br>

## Setup the Continuous Integration and Delivery Service

1. Enable SAP Continuous Integration and Delivery 
- Go to your subaccount in SAP BTP
- Go to the Service Marketplace
- Type Continuous into the Search Box
- Choose Create
![Choose create](./cicd1.png)

2. Assign Role Collection

- In your SAP BTP subaccount, choose Security -> Users
- Choose the name of your identity provider and navigate into it.
- Click on the three dots and choose *Assign Role Collection*- Search for CICD Administrator and add the role to your user

3. Ensure that you can open and access the application. Open the BTP cockpit and go to Instances and Subscriptions to access the **Continuous Integration & Delivery** application.
![cicd-app](./cicd3.png)

    This should navigate you to the main page of the application.
![cicd-mainPage](./cicd4.png)

<br>

**NOTE:**
**If you intend to deploy this application on a cluster that has a deployment of the same application, it is recommended to undeploy this installation via your terminal using the command:**
```
helm uninstall incidents-mgmt -n <namespace>
```


## Retrieve Kyma cluster configuration details

Inorder to run the pipeline using the CICD service, you need to create a service account. Follow the below steps to achieve this.

1. First you'll need to create a namespace. For this, open the **Kyma Dashboard** through the **BTP Cockpit** for your subaccount. 

    ![dashboard](./cicd2.png)

    Your dashboard should look like this.
![kyma-dashboard](./cicd5.png)

2. From the left navigation menu click on **Namespaces**. On this page, click on **+ Create Namespace**. 
![namespacePage](./cicd6.png)
    Provide any relevant name of your choice e.g: incidents-namespace. Also Enable Sidecar Injection and click on create.
![namespaceCreation](./cicd7.png)

3. Now for this namespace, you need to create a Service Account. This is a non-human account which will authenticate your pipeline to access your cluster. Read more about [Service Accounts](https://kubernetes.io/docs/concepts/security/service-accounts/). 

    Ensure you are in your created namespace. From the left navigation menu, click on the dropdown **Configuration** and navigate to **Service Accounts**. Here click on **+ Create Service Account**.
    ![serviceAccountPage](./cicd8.png)

    Give your service account a name e.g: incidents-namespace-service-account and click on create.
    ![serviceAccountCreation](./cicd9.png)

4. For your pipeline to access your kyma cluster through this service account, it requires a set of configurations. This is defined in the **KubeConfig** file of the account. 

    To retrieve this, ensure you are on the page of the created service account and click on **Generate TokenRequest**. 
    ![kubeConfig](./cicd10.png)

    Here you can choose the Expiration Seconds as desired from the drop down and click on Generate.
    As seen below, the configuration details should mention a token, your kyma cluster and namespace.
    ![configDetails](./cicd11.png)

    Now click on copy as these details will be needed to create your pipeline credentials as described in the step below. 

5. Navigate to the Continuous Integration and Delivery Application (follow the steps mentioned above). On this page click **Credentials** and click on the **\+** to create a new credential. 

    Choose a relevant name for your credential e.g: kube-config and for the Type choose **Kubernetes Configuration** from the dropdown. In the Content space, paste the KubeConfig file of the service account you copied from the previous step. Finally click create.
    ![credential](./cicd12.png)

6. Additionaly you need to add your service account to a **Cluster Role Binding**. For this go back to your Cluster and from the left menu Click **Configurations** and navigate to **Cluster Role Bindings**. Here click on any **admin** role binding.
![binding](./cicd13.png)

    On this page click on edit.
![edit](./cicd14.png)
    Here click on **Add Subject** and click on the last row (newly created subject). For the User name, enter the value in the form `system:serviceaccount:<namespace>:<service-account>`. Refer to the image below for more clarity. Finally click on update. 
![subject](./cicd15.png)

<br>

## Get docker credentials
For your pipeline to be able to push and pull images from your docker repository, you need to set your docker credentials for your job. 

1. To run this pipeline you would need your credentials to be base64-encoded. To obtain these credentials, login to your registry from the terminal using the below command.
    ```
    docker --config /tmp login docker.io
    ```
    Provide your credentials if prompted.

2. Run the below command
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
3. In order retrieve the credentials in desired format, you will have to remove the `credsStore` key-value pair.
    ```json
    {
        "auths": {
            "https://index.docker.io/v1/": {}
        }
        ,   // [!code --] 
        "credsStore": "osxkeychain"  // [!code --] 
    }   
    ```
4. Now again run the same login command mentioned in step 1. You will need to input your credentials again. Print the credentials in the same manner as shown in step 2. Ensure your credentials are in this form
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
2. Now you would need to add these docker credentials as a CICD credential. Navigate to the Continuous Integration and Delivery Application (follow the steps mentioned above). On this page click **Credentials** and click on the **\+** to create a new credential. 

    Choose a relevant name for your credential e.g: docker-config and for the Type choose **Container Registry Configuration** from the dropdown. In the Content space, paste the docker configurations you retrieved from the previous step. Click create.
![credentials](./cicd16.png)
 
<br>

## Pipeline configuration 
1. In the root folder create a folder `.pipeline`. Within this folder create a new file `config.yml`.

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
        deploymentName: incidents-mgmt
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
          containerImageName: <your-container-registry>/incidents-mgmt-srv
          containerImageAlias: <your-container-registry>/incidents-mgmt-srv
          containerImageTag: <srv-image-version>
        - path: gen/db
          containerImageName: <your-container-registry>/incidents-mgmt-hana-deployer
          containerImageAlias: <your-container-registry>/incidents-mgmt-hana-deployer
          containerImageTag: <hana-deployer-image-version>
        - path: app/incidents
          containerImageName: <your-container-registry>/incidents-mgmt-html5-deployer
          containerImageAlias: <your-container-registry>/incidents-mgmt-html5-deployer
          containerImageTag: <htmk5-deployer-image-version>
      helmExecute:
        helmCommand: dependency
        dependency: update
    ```

4. Now you'll need to make changes to the `config.yml` file. In the `Release` stage change the **kubeConfigFileCredentialsId** and **namespace**.
![release](./cicd17.png)
    The parameter `kubeConfigFileCredentialsId` should have the same value as the name given to your **Kubernetes Configuration** credential. Refer to section [Retrieve Kyma cluster configuration details](./add-cicd.md#retrieve-kyma-cluster-configuration-details), step 5. 

    The parameter `namespace` should be the same value as the one you created in your kyma cluster in step 2 [Retrieve Kyma cluster configuration details](./add-cicd.md#retrieve-kyma-cluster-configuration-details).

5. Navigate to the `cnbBuild` step and change the values of **dockerConfigJsonCredentialsId** and the **containerImageName, containerImageAlias and containerImageTag**.
![cnbBuild](./cicd18.png)
    For the parameter `dockerConfigJsonCredentialsId`, it should be the same value as the credential name given for the **Container Registry Configuration** credential created in step 5, section [Get docker credentials](./add-cicd.md#get-docker-credentials).

    The parameters for the images must be changed with your docker registry name wherever mentioned. The preferred image versions must also be mentioned wherever relevant. 

<br>

## Prepare your code

1. Open the `package.json` file and add a script to run `cds build`.
    ```json
    "scripts": {
        "watch": "cds watch",
        "start": "cds-serve",
        "test": "npx jest --silent",
        "cds-build": "npm install --include=dev && cds build --production" // [!code ++] 
    },
    ```
2. Push these changes to your main branch from the **Source Control** by first staging and commiting. 
![pushChanges](./cicd32.png)

<br>

## Create the pipeline

1. The first step would be to create a new credential for GitHub:
    - Name: "github"
    - Type: Basic Authentication
    - Username: add your GitHub username/ id
    - Password: enter your GitHub access token 

    Choose **Create**
 ![configure pipeline](./cicd33.png)

2. Go back to the **Jobs** tab and choose **+** icon to create a new Job

3. Under **General Information** add the following data:

    - Job Name: "incidentManagement"
    - Repository: Click the highlighted button. Then click on **Add Repository**
![configure pipeline](./cicd34.png)
![addRepository](./cicd35.png)

4. 4. Provide the information to your GitHub repository that you had created initially.

    - Name: &lt;add your repo name&gt;
    - Clone URL: &lt;add your repo-URL&gt;
    - Credentials: &lt;add the credentials that you created in step 1.&gt;
    - Type: GitHub
![configure pipeline](./cicd25.png)

5. Back in the **Add Repository** screen choose **Add** to finish

6. Back in the **General Information** tab continue configuring the Job:
 
  - Branch: main
  - Pipeline: Kyma Runtime
 ![configure pipeline](./cicd20.png)

7. In **Stages** section choose **Source Repository** as your **Configuration Mode** from the dropdown. 
 ![sourceRepo](./cicd21.png)

<br>

## Run the pipeline and see your deployment
1. Now you can test your job manually the first time after creation. Go back to the **SAP Continuous Integration and Delivery** application and navigate to the **Job** tab

2. Choose the name of your created job and choose **Run**
![configure pipeline](./cicd22.png)

3. You can monitor your pipeline through the logs of the different stages.
![logs](./cicd23.png)

4. The outcome of installation will look something like this in the **Release** stage.
![deploy](./cicd24.png)
<br>

5. [Assign Application Roles](../assign-application-roles/assign-application-roles.md) to be able to access the application.

6. Proceed to [Integrate with SAP Build Work Zone](https://developers.sap.com/tutorials/integrate-with-work-zone..html) to access the application in launchpad from SAP Build Work Zone, standard edition.
