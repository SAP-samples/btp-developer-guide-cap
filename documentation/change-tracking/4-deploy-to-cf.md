## Deploy to Cloud Foundry

1. Run the following command to assemble everything into a single `mta.tar` archive:

```
mbt build
```

See [Multitarget Applications in the Cloud Foundry Environment](https://help.sap.com/products/BTP/65de2977205c403bbc107264b8eccf4b/d04fc0e2ad894545aebfd7126384307c.html?locale=en-US) to learn more about MTA-based deployment.



2. Make sure you're logged in to your subaccount:

     ```
    cf api <API-ENDPOINT>
    cf login -u <USER-ID> -p <PASSWORD>
    cf target -o <ORG> -s <SPACE>
    ```

---
**Tip:**

You can find the API endpoint in the **Overview** section of your subaccount.

---

3. Navigate to the `mta_archives` folder and run the following command to deploy the generated archive to Cloud Foundry:

    ```
    cf deploy incident-management_1.0.0.mtar 
    ```

This process can take some minutes and finally creates a log output like this:

```
[…]
Application "incident-management-srv" started and available at
"[org]-[space]-incident-management.landscape-domain.com"
```

You'll need to [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html) before you can access the application.

Next step, proceed to [Integrate with SAP Build Workzone](https://developers.sap.com/tutorials/integrate-with-work-zone.html) to access the application in launchpad.


# Summary

Change tracking has been deployed on Cloud Foundry and integrated into SAP Build Workzone.