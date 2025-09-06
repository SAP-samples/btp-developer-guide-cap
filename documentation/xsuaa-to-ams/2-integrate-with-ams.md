# Integrate with Authorization Management Service


###  Implement in Your Application

1. Execute the following command to add ias and ams:

   ```shell
   cds add ams
   ```

2. Build the project to install the added dependencies
   ```sh
   npm i
   ```
   
3. To compile the **cds annotations** to **dcl files** and start your CAP application in watch mode with debug output enabled for the Authorization Management service runtime and development plug-in, run 
    ```sh
    DEBUG=ams,ams-dev cds w
    ```
    > You can manually generate the DCL files using `cds build --for ams` command.
  
Now, you can see that in ```gen/srv/ams/dcl/cap/basePolicies.dcl``` a policy ```support``` is generated. A user with the policy `cap.support` can view and update the Incidents.

* You can observe that a folder with name `ams` is generated in your root folder. This is where we can define our schema extensions and custom policies.<br />
* Stop the running process with `ctrl+c`.


## Add Users for Local Testing

The authorization checks that you added to the CAP model apply not only when deployed to the cloud but also for local testing. Therefore, we need a way to log in to the application locally.


1. Add the following to your `package.json` file:
    ```json
    {
        "cds": {
            "requires": {
                "[development]": {
                    "auth": {
                            "kind": "mocked",
                            "users": {}
                        } 
                    }
            }
        }
    }
    ```

> This defines which configuration to use when running with the `development` profile. We define some general parameters for the authentication behavior and as the next step, we will define some test users.

3. Add the following property to the `users` in the `package.json` with the following code: 
      ```json
      "users": {
          "alice": {
            "policies" : [
                "cap.support"
            ]
          },
          "bob": {
          }
      }
      ```
> Here, the `policies` array can be used to assign policies to mocked users for local testing. The `roles` property of a user can still be used for manual role assignments to a mocked user. But since we want to test role assignments via AMS, we instead assign the policy for the support role.


## Access the Incidents Application with Password

When accessing the `Incidents` service in your browser, you get a basic authentication popup asking for your username and password. Log in and you can see how it works.

1. With `cds watch` running, go to [http://localhost:4004](http://localhost:4004).
2. Choose **Incidents** and then **Go**.
3. Enter **Username**: `alice`.
4. You can now access the `Incidents` application.

> Currently, there’s no logout functionality. You can clear your browser's cache or simply close all browser windows to get rid of the login data in your browser.
For Google Chrome, restart your browser (complete shutdown and restart) by entering `chrome://restart` in the address line.<br/>

## Next Steps

Now deploy and test our application: [Deploy on SAP BTP Cloud Foundry](./3-deploy-to-cf.md).
