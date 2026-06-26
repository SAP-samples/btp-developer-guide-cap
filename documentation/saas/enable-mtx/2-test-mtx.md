# Test the CAP Application Locally

For local testing of the multitenancy you have enabled, you have to:

1. Verify that the `[with-mtx]` profile exists in the root `package.json`. The command `cds watch --with-mtx` activates this profile — without it, multitenancy is not enabled in the main app:

    ```json
    "cds": {
      "requires": {
        "[with-mtx]": {
          "multitenancy": true
        }
      }
    }
    ```

### Start the MTX Sidecar

MTX services are implemented in Node.js and can run in the same Node.js server as your application services or in separate micro services called sidecars. Use the following command to start the MTX sidecar:

```sh
cds watch mtx/sidecar
```

### Add Roles for Local Testing
The [predefined users](https://cap.cloud.sap/docs/node.js/authentication#mock-users) can be enhanced or overwritten in the `package.json` file. Here, the users need the `support` role to access the application. Add the following code in the `package.json` file to assign the `support` role to the user called `erin`.
Here `alice` belongs to tenant `t1`, and `erin` belongs to tenant `t2`.

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
              ],
              "tenant": "t1"
            },
            "bob": {
              "roles": [
                "support"
              ]
            },
            "erin": {  
              "roles": [ 
                "support"
              ],
              "tenant": "t2"
            } 
          }
        }
      },
```

Before deploying the Incident Management application to production, you can test the common SaaS operations with your application locally, including the SaaS startup, subscribing tenants, and upgrading tenants.