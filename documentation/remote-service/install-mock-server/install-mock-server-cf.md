# Option 1 - Install Mock Server in SAP BTP Cloud Foundry Runtime

## Usage Scenario

If you don't have access to an SAP backend system (SAP ECC, SAP S/4HANA or an SAP on-premise system) but still need OData services with some data, you can use this [mock server application](https://github.com/SAP-samples/cloud-extension-ecc-business-process/blob/mock/README.md). It contains some entities of SAP OData services with sample data.

In essence, you need to 
1. Install the mock server using [SAP Business Application Studio](#option-1-install-the-mock-server-using-sap-business-application-studio).

2. Have an additional 256 MB of Cloud Foundry runtime required for deploying the mock server.

3. Create a [destination](#create-destination-to-mock-server) to the mock server in the same SAP BTP subaccount.

> This installation of the mock server is only needed if you want to test an application deployed for Cloud Foundry. For running local developement test, you can use the local mock server. 

## Install the Mock Server Using SAP Business Application Studio

### Create Workspace

1. Open the SAP Business Application Studio. Choose **Create a New Dev Space** and check the **Full Stack Cloud Application** radio button.

2. Open a new terminal.

### Log In to Cloud Foundry in SAP Business Application Studio

**In SAP BTP cockpit:**
1. Navigate to your subaccount and choose **Overview**. Copy the values from the **Org Name** and **API Endpoint** parameters in a text editor of your choice.

2. In the left-hand navigation, choose **Cloud Foundry** &rarr; **Spaces**, copy the **Space name** and write it in a text editor of your choice.

**In SAP Business Application Studio:**
1. In the tabs, choose **View** and select **Command Palette**.

2. Search for **CF Login** and select **CF: Login to Cloud Foundry**.

3. Enter the Cloud Foundy API endpoint you have copied from SAP BTP cockpit or take the default suggested API endpoint.

4. When prompted, enter your the email and password for your global account in SAP BTP.

5. Select your Cloud Foundry Org, the same you have copied from SAP BTP cockpit. 

6. Then, select the Cloud Foundry Space, the same you have copied from SAP BTP cockpit. 

7. Once you have selected the Org and the Space, log in to Cloud Foundry in SAP Business Application Studio.

**Result:** you have successfully created a workspace and pointed to your desired Cloud Foundry Org and Space.

### Build and Deploy the Mock Server Application

1. In SAP Business Application Studio, choose **Terminal** &rarr; **New Terminal** and navigate to the projects folder using:

   ```bash
      cd projects
   ```

2. Clone the mock server GitHub repository:

   ```bash
      git clone -b mock https://github.com/SAP-samples/cloud-extension-ecc-business-process.git
   ```

3. In the menu, choose **File** and then choose **Open Workspace** from the dropdown menu.

4. To open the project, choose **projects** &rarr; **cloud-extension-ecc-business-process** and then choose **Open**.

5. In the project folder, right-click on the **mta.yaml** file and choose **Build MTA Project**.

6. When the project is built successfully, you will see a new **mta_archives** folder in your project with the **Mockserver_1.0.0.mtar** file inside. Right-click on that file and choose **Deploy MTA Archive**.

Now you need to create a destination to the the mock server.

## Create Destination to Mock Server

1. In SAP BTP cockpit, go to your subaccount and navigate to the space where you have deployed the mock server. In the **Applications** section, choose the **mock-srv** application.

2. In the application overview screen, copy the **Application Route** of the mock server.

3. Go back to the subaccount overview and choose **Connectivity** &rarr; **Destination**. Then, choose **New Destination**. 
  1. Enter the following values:

      * **Name** = *[Some destination name depending on your mission]*
      * **Type** = HTTP
      * **URL** = *[URL for your OData entities]* e.g. https://\<The application route of the mock server\>/v2/op-api-business-partner-srv/
      * **Proxy Type** = Internet
      * **Authentication** = NoAuthentication

  2. Select the **Use default JDK truststore** checkbox.

  3. Save your settings.

4. Choose **Check Connection**. You should get a `200 OK` message.

## Test the Mock Server

1. Call the **Application Route**.

2. There will be a couple of API endpoints to display the data.
