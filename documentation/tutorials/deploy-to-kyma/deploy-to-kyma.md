---
title: Deploy in SAP BTP, Kyma Runtime
description: This tutorial shows you how to deploy your CAP application in SAP BTP, Kyma runtime.
keywords: cap 
parser: v2
auto_validation: true
time: 30
tags: [ tutorial>beginner, software-product-function>sap-cloud-application-programming-model, programming-tool>node-js, software-product>sap-business-technology-platform, software-product>sap-fiori]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Grzegorz Karaluch
author_profile: https://github.com/grego952
---


## You will learn

- How to deploy your CAP application in SAP BTP, Kyma runtime.

## Prerequisites

- You've configured the respective entitlements, enabled the Kyma runtime in your subaccount, and created an SAP HANA Cloud service instance in the SAP BTP cockpit. Follow the steps in the [Prepare for Deployment in the SAP BTP, Kyma Runtime](prepare-btp-kyma) tutorial that is part of the [Deploy a Full-Stack CAP Application in SAP BTP, Kyma Runtime Following SAP BTP Developer’s Guide](https://developers.sap.com/group.deploy-full-stack-cap-kyma-runtime.html) tutorial group.
- You have an [enterprise global account](https://help.sap.com/docs/btp/sap-business-technology-platform/getting-global-account#loiod61c2819034b48e68145c45c36acba6e) in SAP BTP. To use services for free, you can sign up for an SAP BTPEA (SAP BTP Enterprise Agreement) or a Pay-As-You-Go for SAP BTP global account and use the free tier services only. See [Using Free Service Plans](https://help.sap.com/docs/btp/sap-business-technology-platform/using-free-service-plans?version=Cloud).
- You have a platform user. See [User and Member Management](https://help.sap.com/docs/btp/sap-business-technology-platform/user-and-member-management).
- You're an administrator of the global account in SAP BTP.
- You have a subaccount in SAP BTP to deploy the services and applications.
- You have a tenant of SAP Cloud Identity Services. See [Get Your Tenant](https://help.sap.com/docs/cloud-identity-services/cloud-identity-services/get-your-tenant) for details how to get a tenant of SAP Cloud Identity Services if you don't have one yet.
- You've established trust between your tenant of SAP Cloud Identity Services and your SAP BTP account. This established trust allows you to use your SAP Cloud Identity Services tenant as an identity provider or a proxy to your own identity provider hosting your business users. See [Establish Trust and Federation Between SAP Authorization and Trust Management Service and SAP Cloud Identity Services](https://help.sap.com/docs/btp/sap-business-technology-platform/establish-trust-and-federation-between-uaa-and-identity-authentication).
- You have one of the following browsers that are supported for working in SAP Business Application Studio:
    - Mozilla Firefox
    - Google Chrome
    - Microsoft Edge
 - For Windows, you need Chocolatey. Chocolatey is a package manager that speeds up and eases installation of the tools in this tutorial. See how to install Chocolatey in [Setup/Install](https://docs.chocolatey.org/en-us/choco/setup).
 - You've prepared a container registry and you've logged in to the container registry through your CLI. A container registry is a repo where you can push your Docker images. SAP BTP doesn't currently provide a container registry. You can use any container registry offering as long as it can be reached from the public Internet.

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Introduction

SAP BTP, Kyma runtime is a cloud-native application runtime that combines the power of Kubernetes with a set of best-in-class tools and open-source components that empower you to develop, run, and operate secure and scalable cloud-native applications. Detailed information is available at [Kyma Environment](https://help.sap.com/docs/btp/sap-business-technology-platform/kyma-environment).

The files of the SAP BTP, Kyma runtime are provided as a container image. In addition, since the containers run on Kubernetes, their configuration is described by Kubernetes resources.

Hence, you need two kinds of artifacts to run applications on Kubernetes:

- Container images
- Kubernetes resources

You start by building your project as container images and push those images to a container registry of your choice. Then, you add a [CAP Helm chart](https://cap.cloud.sap/docs/guides/deployment/deploy-to-kyma#about-cap-helm) to your project. As a last step, you deploy the Helm chart to your Kyma resources, where service instances of SAP BTP services are created and pods pull the previously created container images from the container registry.

### Install kubectl

[OPTION BEGIN [macOS]]
1. To install kubectl, run the following command:
```Shell/Bash
brew install kubectl
```
2. Check if the installation is successful:
```Shell/Bash
kubectl version --client
```
You see a version number.
[OPTION END]

[OPTION BEGIN [Windows]]
You can install kubectl using chocolatey.

1. To install kubectl, run the following command:
```Shell/Bash
choco install kubernetes-cli
```
2. Check if the installation is successful:
```Shell/Bash
kubectl version --client
```
You see something like:
`Client Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.3", GitCommit:"1e11e4a2108024935ecfcb2912226cedeafd99df", GitTreeState:"clean", BuildDate:"2020-10-14T12:50:19Z", GoVersion:"go1.15.2", Compiler:"gc", Platform:"windows/amd64"}`
[OPTION END]

[OPTION BEGIN [Linux]]
Follow the instructions for your preferred way of installing kubectl at [Install and Set Up kubectl on Linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/).
[OPTION END]

### Install kubelogin

[OPTION BEGIN [macOS]]
To install kubelogin, run the following command:
```Shell/Bash
brew install int128/kubelogin/kubelogin
```
See [Setup](https://github.com/int128/kubelogin#setup) in the kubelogin docs for more details.
[OPTION END]

[OPTION BEGIN [Windows]]
You can install kubelogin using chocolatey:

```Shell/Bash
choco install kubelogin
```

See [Setup](https://github.com/int128/kubelogin#setup) in the kubelogin docs for more details.
[OPTION END]

[OPTION BEGIN [Linux]]
To install kubelogin, run the following command:
```Shell/Bash
brew install int128/kubelogin/kubelogin
```

See [Setup](https://github.com/int128/kubelogin#setup) in the kubelogin docs for more details.
[OPTION END]

### Log in to your Kyma cluster

1. Choose `KubeconfigURL` under the **Kyma Environment** tab in your subaccount.

    <!-- border; size:540px --> ![Kubeconfig URL](kubeconfigURL.png)

    A file `kubeconfig.yaml` is downloaded.

    <!-- border; size:540px --> ![Kubeconfig yaml](kubeconfig_yaml.png)

2. Copy the `kubeconfig.yaml` file to the `~/.kube/` directory and rename it to `config`. Replace or rename any existing file with the same name.


There are two additional steps for Windows users only:

3. Go to `C:\ProgramData\chocolatey\bin`.

4. Rename `kubelogin.exe` to `kubectl-oidc_login.exe`.

### Install helm

[OPTION BEGIN [macOS]]
There's a multitude of options to install helm. You can see the full list at [Installing Helm](https://helm.sh/docs/intro/install/). We have also listed some options:

To install helm, run the following command:
```Shell/Bash
brew install helm
```
[OPTION END]

[OPTION BEGIN [Windows]]
There's a multitude of options to install helm. You can see the full list at [Installing Helm](https://helm.sh/docs/intro/install/). We have also listed some options:

You can install helm using chocolatey.

1. To install helm, run the following command:
```Shell/Bash
choco install kubernetes-helm
```
2. Check if the installation is successful:
```Shell/Bash
helm version
```
You see something like `version.BuildInfo{Version:"v3.8.0", GitCommit:"d14138609b01886f544b2025f5000351c9eb092e", GitTreeState:"clean", GoVersion:"go1.17.5"}`.
[OPTION END]


### Install Paketo (pack)

[OPTION BEGIN [macOS]]
Pack lets you build container images, which are collaboratively maintained making it easier to maintain and update.

```Shell/Bash
brew install buildpacks/tap/pack
```
[OPTION END]

[OPTION BEGIN [Windows]]
Pack lets you build container images, which are collaboratively maintained making it easier to maintain and update.

You can install pack using chocolatey with the command:
```Shell/Bash
choco install pack
```
As an alternative, you can install `pack` manually:

1. Download `pack` for your platform from [GitHub](https://github.com/buildpacks/pack/releases).
2. Extract the `pack` binary.
3. Enter **Edit the System Environment Variables** in the Windows search box (Windows icon in the task bar). The **System Properties** dialog is opened.
4. Choose **Environment Variables...**.
5. Choose your `Path` environment variable under *User Variables for `<your_user_name>`* and choose **Edit**.
6. Choose **Browse** and navigate to the folder where you extracted the `pack` binary.
7. Choose **OK** to add `pack` to your `Path` environment variable.
[OPTION END]

[OPTION BEGIN [Linux]]
Pack lets you build container images, which are collaboratively maintained making it easier to maintain and update.

Follow the instructions to install the [pack CLI](https://buildpacks.io/docs/tools/pack/#install).
[OPTION END]

### Install a container management app

[OPTION BEGIN [Docker Desktop]]

Kyma runs on containers. Hence, for this tutorial, you need an application that enables you to manage (build, push, pull, and run) container images on your desktop and a docker-compatible command-line interface. We provide two examples - Docker Desktop and Rancher Desktop. You can pick one of them or any other app suitable for the purpose.


* **macOS**: Download the installer from [Install Docker Desktop on Mac](https://docs.docker.com/desktop/mac/install/) and follow the instructions to install and set up Docker Desktop.

* **Windows**: Download the installer from [Install Docker Desktop on Windows](https://docs.docker.com/desktop/windows/install/) and follow the instructions to install and set up Docker Desktop.

[OPTION END]
[OPTION BEGIN [Rancher Desktop]]

Kyma runs on containers. Hence, for this tutorial, you need an application that enables you to manage (build, push, pull, and run) container images on your desktop and a docker-compatible command-line interface. We provide two examples - Docker Desktop and Rancher Desktop. You can pick one of them or any other app suitable for the purpose.


* **macOS**:

    1. Go to the [releases](https://github.com/rancher-sandbox/rancher-desktop/releases) page.
    2. Download the Rancher Desktop installer for macOS.

        > The macOS installer is called `Rancher.Desktop-<version.architecture>.dmg`. Here's an example with the current latest version: `Rancher.Desktop-1.2.1.x86_64.dmg`.

    3. Run the installer. When the installation is complete, drag the Rancher Desktop icon to the **Applications** folder.

        > You can find details about installation requirements and install/uninstall steps in [macOS](https://docs.rancherdesktop.io/getting-started/installation#macos).

* **Windows**:

    1. Go to the [releases](https://github.com/rancher-sandbox/rancher-desktop/releases) page.
    2. Download the Rancher Desktop installer for Windows.

        > The Windows installer is called `Rancher.Desktop.Setup.<version>.exe`. Here's an example with the current latest version: `Rancher.Desktop.Setup.1.2.1.exe`.

    3. Run the installer. When the installation is complete, choose **Finish**.

        > You can find details about installation requirements and install/uninstall steps in [Windows](https://docs.rancherdesktop.io/getting-started/installation#windows).

* **Linux**: There are several different ways to install Rancher Desktop on Linux. You can find details about installation requirements and steps to install or uninstall steps in [Linux](https://docs.rancherdesktop.io/getting-started/installation#linux).

[OPTION END]

### Download and set up the project locally

1. Skip this step if you cloned the application from the [Incident Management application GitHub repository](https://github.com/cap-js/incidents-app/tree/beginner-tutorials) without going through the application development steps. Perform this step only in case you've developed the application from the start following the tutorials in the [Develop a Full-Stack CAP Application Following SAP BTP Developer’s Guide](https://developers.sap.com/group.cap-application-full-stack.html) group.

    1. In SAP Business Application Studio, choose the icon to download dev space content.

        <!-- border; size:540px --> ![Download dev space content](./downloadproject.png)

        > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

    2. Extract the **incident-management** folder from the downloaded archive.


3. Open a command-line window in the folder where your application resides (for example, **incident-management** if developed from the start or **incidents-app** if cloned from GitHub) and run the following command to open the project in VS Code:

    ```bash
    code .
    ```

### Prepare your application

[OPTION BEGIN [Node.js]]
> Make sure you're logged in to your container registry.

1. In VS Code, choose **Terminal** &rarr; **New Terminal** and run the following command:

    ```bash
    npm install
    ```

    This command installs the required dependencies and updates the **package-lock.json** file of your project.

2. In your terminal, run the following command:

    ```bash
    cds add workzone
    ```

3. Run the following command to get the domain name of your Kyma cluster:

    ```bash
    kubectl get gateway -n kyma-system kyma-gateway \
            -o jsonpath='{.spec.servers[0].hosts[0]}'
    ```

    The result looks like this:

    ```bash
    *.<xyz123>.kyma.ondemand.com
    ```

    > `<xyz123>` is a placeholder for a string of characters that's unique for your cluster.

4. Provide a Helm chart:

    ```bash
    cds add kyma
    ```

[OPTION END]
[OPTION BEGIN [Java]]

> Make sure you're logged in to your container registry.

1. In VS Code, choose **Terminal** &rarr; **New Terminal** and run the following command:

    ```bash
    npm install
    ```

    This command installs the required dependencies and updates the **package-lock.json** file of your project.

2. Add configuration for the managed App Router: 

    ```bash
    cds add workzone
    ```

3. Run the following command to get the domain name of your Kyma cluster:

    ```bash
    kubectl get gateway -n kyma-system kyma-gateway \
            -o jsonpath='{.spec.servers[0].hosts[0]}'
    ```

    The result looks like this:

    ```bash
    *.<xyz123>.kyma.ondemand.com
    ```

    > `<xyz123>` is a placeholder for a string of characters that's unique for your cluster.

4. Provide a Helm chart:

    ```bash
    cds add kyma
    ```

    Provide your container registry and the domain name when prompted.

5. In the VS Code terminal, navigate to the **app/incidents** folder and run the following command:

    ```bash
    npm install && npm run build
    ```

[OPTION END]

### Deploy the application

[OPTION BEGIN [Node.js]]
1. Run the following command to create a namespace:

    ```bash
    kubectl create namespace incident-management
    kubectl label namespace incident-management istio-injection=enabled
    ```

2. Run the following command to get the domain name of your Kyma cluster:

    ```bash
    kubectl get gateway -n kyma-system kyma-gateway \
            -o jsonpath='{.spec.servers[0].hosts[0]}'
    ```

    The result looks like this:

    ```bash
    *.<xyz123>.kyma.ondemand.com
    ```

    > `<xyz123>` is a placeholder for a string of characters that's unique for your cluster.

3. Make sure that your SAP HANA Cloud instance is running. Free tier HANA instances are stopped overnight.

    > Your SAP HANA Cloud service instance is automatically stopped overnight, according to the time zone of the region where the server is located. That means you need to restart your instance every day before you start working with it.
    >
    > You can either use the SAP BTP cockpit or the terminal in the SAP Business Application Studio to restart the stopped instance:
    >
    > ```bash
    > cf update-service incident-management -c '{"data":{"serviceStopped":false}}'
    > ```

4. Deploy using the `cds up` command:

    ```bash
    cds up -2 k8s --namespace incident-management
    ```

5. You may be asked to create your Docker imagePullSecret. If so, follow the provided instructions.

    The `cds up -2 k8s --namespace incident-management` command installs the Helm chart from the **chart** folder with the release name **incident-management** in the namespace **incident-management**.

    The outcome of the installation looks like this:

    <!-- border; size:540px --> ![Deployed app](./deployedapp.png)

<!-- 6. Enter the route displayed for **srv** in your browser. -->

<!-- border; size:540px ![Depoyed app route](./deployedapp-route.png) -->

<!--     You see the CAP start page: -->

<!-- border; size:540px ![CAP start page](./cap-start-page.png) --> 

<!-- 4. When you choose the **Incidents** service entity, you will see an error message.  -->

<!-- border; size:540px  ![401 error](./401-error.png) -->

In the next tutorial, you can access your UIs from SAP Build Work Zone, standard edition. The SAP Build Work Zone, standard edition triggers the authentication flow to provide the required token to access the service.

[OPTION END]
[OPTION BEGIN [Java]]

1. Run the following command to create a namespace:

    ```bash
    kubectl create namespace incident-management
    kubectl label namespace incident-management istio-injection=enabled
    ```

2. Make sure that your SAP HANA Cloud instance is running. Free tier HANA instances are stopped overnight.

    > Your SAP HANA Cloud service instance is automatically stopped overnight, according to the time zone of the region where the server is located. That means you need to restart your instance every day before you start working with it.
    >
    > You can either use the SAP BTP cockpit or the terminal in the SAP Business Application Studio to restart the stopped instance:
    >
    > ```bash
    > cf update-service incident-management -c '{"data":{"serviceStopped":false}}'
    > ```

3. Deploy using the `cds up` command:

    ```bash
    cds up -2 k8s --namespace incident-management
    ```

    > If you experience the `TypeError: Cannot read properties of undefined (reading 'global')` error, run the `cds up` once again.

4. You may be asked to create your Docker imagePullSecret. If so, follow the provided instructions.

    The `cds up -2 k8s --namespace incident-management` command installs the Helm chart from the **chart** folder with the release name **incident-management** in the namespace **incident-management**.

    The outcome of the installation looks like this:

    <!-- border; size:540px --> ![Deployed app](./deployedapp.png)

<!-- 6. Enter the route displayed for **srv** in your browser. -->

<!-- border; size:540px ![Depoyed app route](./deployedapp-route.png) -->

<!--     You see the CAP start page: -->

<!-- border; size:540px ![CAP start page](./cap-start-page.png) --> 

<!-- 4. When you choose the **Incidents** service entity, you will see an error message.  -->

<!-- border; size:540px  ![401 error](./401-error.png) -->

In the next tutorial, you can access your UIs from SAP Build Work Zone, standard edition. The SAP Build Work Zone, standard edition triggers the authentication flow to provide the required token to access the service.
[OPTION END]