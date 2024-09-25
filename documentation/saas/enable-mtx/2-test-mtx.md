# Test the CAP Application Locally

For local testing of the multitenancy you have enabled, you have to:

1. Create a new profile that contains the multitenancy configuration:

    ```sh
    cds add multitenancy --for local-multitenancy
    ```
2. Install the multitenancy module dependencies using the following command:

    ```sh
    cd mtx/sidecar
    npm i
    ```

### Start the MTX Sidecar

MTX services are implemented in Node.js and can run in the same Node.js server as your application services or in separate micro services called sidecars. Use the following command to start the MTX sidecar:

```sh
cds watch mtx/sidecar
```

### Add Roles for Local Testing
The [predefined users](https://cap.cloud.sap/docs/node.js/authentication#mock-users) can be enhanced or overwritten in the package.json file. Here, the users need the `support` role to access the application. Add the following code in the package.json file to assign the `support` role to the user called Erin.
Here Alice belongs to tenant1, and Erin belongs to tenant2.

```json
  ...
      "[development]": {
        "auth": {
          "kind": "mocked",
          "users": {
            ...
            "alice": {
              "roles": [
                "support"
              ]
            },
            "bob": {
              "roles": [
                "support"
              ]
            },
            "erin": {  
              "roles": [ 
                "support"
              ] 
            } 
          }
        }
      },
```
Before deploying the Incident Management application to production, you can test the common SaaS operations with your application locally, including the SaaS startup, subscribing tenants, and upgrading tenants.
> **TIP:** Details using multiple terminals...
In the following steps, we start two servers, the main application and the MTX sidecar, and run some commands. So, you need three terminal windows.
