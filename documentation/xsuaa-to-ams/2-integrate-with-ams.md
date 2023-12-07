# Integrate with Authorization Management Service


 ###  Implement in Your Application

 1. Add the following dependency to  `package.json/dependencies`
    ```
    "@sap/ams": "^1.13.1"
    ```
 2. Add the following dependency to  `package.json/devDependencies`
    ```
    "@sap/ams-dev": "^0.7.1"
    ```
  3. Make sure you have `@sap/xssec` dependency with version greater that `3.3.5`
      ```
      "@sap/xssec": "^3.3.5",
      ```
 3. Add the following code to  `package.json/cds/requires/[development]/auth`: 
    ```
            "ams" : {
            "autoCompile" : true,
            "cache" : {
                "TTL" : 0
            }
        }
    ```
 4. Build the project to install the added dependencies
    ```
    npm i
    ```
 5. To compile the **cds annotations** to **dcl files** and start your CAP application in watch mode with debug output enabled for the Authorization Management service runtime and development plug-in, run 
    ```
    DEBUG=ams cds w
    ```
  
Now, you can see that in ```ams/dcl/cap/basePolicies.dcl``` a policy ```cap.support (Not restricted)``` is generated. A user with the policy `cap.support (Not restricted)` can view and update the incidents and customers.

* After successful compilation, you can observe that folder with name ```ams``` is generated in your root folder. This contains all the `.dcl` files based on your cds annotations.<br />
* Stop the running process with ```ctrl+c```.


## Add Users for Local Testing

The authorization checks that you added to the CAP model apply not only when deployed to the cloud but also for local testing. Therefore, we need a way to log in to the application locally.


1. Add the following to your `package.json` file:
    ```
    {
      "[development]": {
          "auth": {
                "Kind": "mocked",
                "users": {}
              } 
          }
      
    }
    ```

  This defines which configuration to use when running with the `development` profile. We define some general parameters for the authentication behavior and as the next step, we will define some test users.

3. Add the following property to the `users` in the `package.json` with the following code: 


      ```
          "users": {
              "alice": {
                "policies" : [
                    "cap.support (Not restricted)"
                ]
              },
              "bob": {
              }
          }
      ```
  Here, the `policies` array can be used to assign policies to mocked users for local testing. The `roles` property of a user can still be used for manual role assignments to a mocked user. But since we want to test role assignments via AMS, we instead assign the policy for the support role.


## Access the Incidents Application with Password

When accessing the `Incidents` service in your browser, you get a basic authentication popup asking for your username and password. Log in and you can see how it works.

1. With `cds watch` running, go to <http://localhost:4004>.
2. Choose **Incidents** and then **Go**.
3. Enter **Username**: <span class="impl node"> `alice`.
4. You can now access the `Incidents` application.

>Currently there’s no logout functionality. You can clear your browser's cache or simply close all browser windows to get rid of the login data in your browser.
For Google Chrome, restart your browser (complete shutdown and restart) by entering `chrome://restart` in the address line.<br/>

## Next Steps

Now deploy and test our application: [Deploy on SAP BTP Cloud Foundry](./3-deploy-to-cf.md).
