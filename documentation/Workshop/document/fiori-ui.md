## Create Fiori UI with Joule

This section describes how to create UI application via Joule prompt

## Prerequisites

You have created custom logic using [Create backend logic with Joule](custom-logic.md)

## Generating Fiori UI

1. In the Joule prompt, start typing ```/fiori``` and select **/fiori-gen-cap-ui** from the suggestions.

    ![fiori-ui](../images/fiori-ui/ui_suggestion.png)

2. Use the below Prompt to create the UI.

    ```
    Create an SAP Fiori application named Incident-management with List report page as the template. Data source is local CAP application and use ProcessorService as the odata Service, and incidents is the main entity. Table should be responsive. Application should be created from ProcessorService as the main OData service
    ```

    > Prompt will tell Joule to create a Fiori application with List report as the SAP Fiori template. There might be many services, mention which service needs to be mapped with the UI application. In our case, ProcessorService is the odata Service and incidents is the main entity in it. 

3. Joule responds with `files generated successfully`.

    ![ui-generated-msg](../images/fiori-ui/ui_generated.png)

4. Go to the explorer. Under app folder, check the below folder structure is generated.

    ![fiori-ui](../images/fiori-ui/app_folder.png)

5. Click on `Run and Debug` button to start application.

    ![run-app](../images/fiori-ui/run-app.png)

6. Application will be started and open in new tab. Click on `Fiori application` to view UI.

    ![open-app](../images/fiori-ui/webapp_ui.png)

7. List report page opens in new tab. Click on `Go` button to view list of Incidents.

    ![list-report-page](../images/fiori-ui/UI_listpage.png)

8. Click on one of the Incidents. It opens the incident details.

    ![object-page](../images/fiori-ui/Incident-object-page.png)

9. To Stop the running application, at top of the screen, you will find the disconnect icon as per the image below.
    
    ![stop-preview](../images/fiori-ui/stop_preview.png)

## Next Step

**[Optional]** If you want to Enhance the UI, follow [Extend fiori ui](./extend-fiori-ui.md). 

To deploy your developed Application to Cloud Foundry Runtime, follow [Deploy in SAP BTP, Cloud Foundry Runtime](deploy-cf.md)


