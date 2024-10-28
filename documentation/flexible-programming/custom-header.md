# Add Custom Header Section

In this section, you will edit the Object Page with the SAP Fiori Tools page editor and add the custom header section using the **Flexible Programming Model**. This custom header section is to showcase the Micro Process Flow. The processor can use the  [MicroProcessFlow](https://sapui5.hana.ondemand.com/#/api/sap.suite.ui.commons.MicroProcessFlow) control to track the progress of an incident.

Before you start with the next steps, make sure the steps in [Extension Points: Add Custom Column](./custom-column.md) are completed.

## Edit Object Page

1. In the **Application Info - incidents** tab, click the **Open Page Map** tile. 

    <!-- border; size:540px --> 
    ![Page Map](./images/PageMap.png)

    > In case the **Application Info - incidents** tab is closed: 
    >
    >1. Invoke the Command Palette - **View** &rarr; **Command Palette** or <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for macOS / <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for Windows. 
    >2. Choose **Fiori: Open Application Info**.

2. In the **IncidentObjectPage** tile, click the **Pencil** icon next to the title.

    <!-- border; size:540px --> 
    ![Edit object page](./images/obj0.png)

3. In the **Header** &rarr; **Header Sections**. Click the **+** icon and choose **Add Custom Section**.

     ![step3](./images/custom-header-1.png)

4. In the popup, enter the following details.

    | Key  | Value  |
    |---|---|
    | **Title**  | `Process`. Click the **Globe** icon to generate a translatable text key.  |
    | **Select View Mode Fragment**  | `Use Existing Fragment`  |
    | **View Mode Fragment Name**  | `StatusProcess (ns.incidents.ext.fragment.StatusProcess)`. Select it from the dropdown list. |
    
    ![step 4](./images/custom-header-2.png)

5. Choose **Add**.

This will use the existing fragment and handler file that you've generated in the [Add Custom Column](./custom-column.md) section.

## Check the result

1. In SAP Business Application Studio, you might need to close the session of the **SAP Fiori tools: Application Modeler** in the terminal, if there is an open one.
2. Go to the **Application Info - incidents** tab, and click the **Preview Application** tile.
3. The application opens in a separate tab of the browser. 

The header section in the Object page of the Incident Management application should look like this:

![result](./images/intro-custom-header.png)
