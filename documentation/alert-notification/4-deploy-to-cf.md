# Deploy and Run the Application in SAP BTP, Cloud Foundry Runtime

While we simply dumped notifications to **stdout** in local development, we'll be using the **SAP Alert Notification service for SAP BTP** in **production**.

## Set Up Instance and Deploy Application

1. Run the command `cds add mta`. This will add the notification deployer to the application.

2. Under the `notification-content-deployment`, change the `memory` and `disk` quota to `500MB`.

3. Build the mta archive.

    ```bash
    mbt build
    ```
    You should be able to see the mta archive in the **mta_archives** folder.

4. Deploy your application.

    ```bash
    cf deploy mta_archives/< mtar_name >.mtar
    ```
    
5. To be able to access the application via the URL, you need to assign roles to users. See [Assign Application Roles](https://developers.sap.com/tutorials/user-role-assignment.html).
