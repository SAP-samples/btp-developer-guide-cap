# Option 2 - Install Mock Server in SAP BTP Kyma Runtime

## Usage Scenario

If you don't have access to an SAP backend system (ECC, SAP S/4HANA or SAP on-premise system) but still need OData services with some data, you can use this [mock server application](https://github.com/SAP-samples/cloud-extension-ecc-business-process/blob/mock/README.md). It contains some entities of SAP OData services with sample data.

In essence, these are the steps you need to follow:
1. Install the mock server [SAP Business Application Studio](#option-1-install-the-mock-server)

2. Create a [destination](#create-destination-to-mock-server) to the mock server in the same subaccount as your SAP AppGyver subscription.

> This installation of the mock server is only needed if you want to test an application deployed for Kyma Runtime. For running local developement test you could use the local mock server. 

## Install the Mock Server Using SAP Business Application Studio

### Prerequisites

1. [Access Kyma instance using kubectl](https://help.sap.com/docs/btp/sap-business-technology-platform/access-kyma-instance-using-kubectl?locale=244dbc262b5c4d37a42cfd7405e4719e.html)

2. Verify login to Kyma instance

    ```bash
    kubectl get pods
    ```

3. Ensure you deploy the Incident Management Application and the Mock Server to the same Kyma namespace.

### Build and Deploy the Mock Server Application

1. Clone the mock server GitHub repository:

   ```bash
      git clone -b mock https://github.com/SAP-samples/cloud-extension-ecc-business-process.git
   ```

2. Build the application using

    ```bash
    cds build --production
    ```

3. Build an image and publish the image using

    ```bash
    pack build <your-container-registry>/mockserver-srv:latest --path gen/srv --builder paketobuildpacks/builder-jammy-base --publish
    ```

4. CAP provides a configurable Helm chart for Node.js applications. Add helm charts using

    ```bash
    cds add helm
    ```

5. The above command also adds configurations for enterprise-messaging service instance. We will be needing this while enhancing the application with Eventing. So, as of now lets remove the references of enterprise-messaging from charts folder

   In Values.yaml file:
   
   - From `srv/bindings` remove
   
        ```yaml
        messaging:
            serviceInstanceName: event-mesh
        ```

   - Remove event-mesh service instance creation

        ```yaml
        event-mesh:
            serviceOfferingName: enterprise-messaging
            servicePlanName: default
        ```

    From `Chart.yaml` file remove
        
        ```yaml
        - name: service-instance
            alias: event-mesh
            version: ">0.0.0"
        ```

6. Now, lets configure the created Helm Charts.

    - Specify the domain of your cluster in the `chart/values.yaml` file so that the URL of your CAP service can be generated:

    ```yaml
    ...
    domain: <cluster domain>
    ```

    You can use the following command to get the domain name for your Kyma cluster:

    ```yaml
    kubectl get gateway -n kyma-system kyma-gateway \
        -o jsonpath='{.spec.servers[0].hosts[0]}'
    ```

    - Add your container image settings `<your-container-registry>` and `tag` to your `chart/values.yaml`

7. Deploy mock server using

    ```yaml
    helm upgrade --install mock ./chart -n <namespace>
    ```   

8. Get the api url for the installed mock server <To DO>

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

4. Choose **Check Connection**, you should get a `200 OK` message.

## Test the Mock Server

1. Call the **Application Route**.

2. There are couple of options to display the data of the mock server. For example, call the **Open API** endpoint and you will get a Swagger UI where you can test the OData services.