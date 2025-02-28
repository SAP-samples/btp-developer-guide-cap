# Extend Fiori UI

SAP Build Code with Joule is a development tool designed to facilitate the creation of basic applications, providing a streamlined approach to jump-start application development. It enables developers to quickly build foundational applications, which can be further extended and customized as per our requirements. 
In this section let's explore how to extend Fiori UI of an application.

## Prerequisites

You have created the basic UI application using [Create UI with Joule](fiori-ui.md)

## Configure the List Report

In this section, you'll modify the List Report with the SAP Fiori Tools page editor.

1. Choose the burger menu and then choose **View → Command Palette**.

    ![open-command-palette](../images/extend-fiori-ui/open-command-palette.png)

    > You can also invoke the Command Palette quickly using the following key combination:  
    > <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for macOS.        
    >  <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for Windows. 

2. Type **Fiori: Open Application Info** in the field and select this entry from the list.

    ![open-app-info](../images/extend-fiori-ui/open-app-info.png)

3. In the **Application Info - incidents** tab, click the **Open Page Map** tile. 

    ![Page Map](../images/extend-fiori-ui/PageMap.png)

### Add filter fields

1.  The page map of the **incidents** application opens in a new tab within SAP Build code. You will see the properties on the right side of the page map. You can edit these properties to update the UI of the application.

    ![Page Map properties](../images/extend-fiori-ui/PageMap-properties.png)

    > In case the **Application Info - incidents** tab is closed: 
    >
    >1. Invoke the Command Palette - **View** &rarr; **Command Palette** or <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for macOS / <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for Windows. 
    >2. Select **Fiori: Open Application Info**.

2. In the **List Report** tile, click the **Pencil** icon next to the title. The page editor is opened.

    ![List Report Page Config](../images/extend-fiori-ui/ls3.png)

3. In the **Filter Bar** section of the page editor, select **Filter Fields** and then click the **Plus** icon to add filter fields. Then, select **Add Filter Fields** in the dropdown menu.

    ![Add Filter Fields](../images/extend-fiori-ui/ls4.png)

4. In the **Add Filter Fields** dialog:

    - Select the **status_code** and **urgency_code** checkboxes in the **Filter Field** dropdown menu.
    - Click **Add**. Your application will be updated to show the new filters.

    ![New Filters Added](../images/extend-fiori-ui/ls5.png)

    > This is how you define which properties are exposed as search fields in the header bar above the list.

### Edit filter fields

5. Select filter field **urgency_code**. In the **Label** field, change the value to **Urgency**.
 
    ![Update filter label](../images/extend-fiori-ui/update-filter-label.png)

6. Click the **Globe** icon to generate a translatable text key and click **Apply**.

    ![Generate Translatable Text Key](../images/extend-fiori-ui/ls10.png)

    > The filter labels are text strings. It's a good idea to update them so they are compliant with internationalization standards (i18n).

    > Learn more about how internationalization works for the backend part in [Where to Place Text Bundles?](https://cap.cloud.sap/docs/guides/i18n#where-to-place-text-bundles) in the CAP documentation.

7. Select the **status_code** filter. In the **Label** field, change the value to **Status**.
8. Click the **Globe** icon to generate a translatable text key and click **Apply**.

    Both filter value helps currently show the corresponding code values when opened. We want to display a descriptive text instead.

    ![Value help display type](../images/extend-fiori-ui/filter-code-values.png)
 
9. For both the **Status** and **Urgency** filters, in the **Display Type** dropdown menu, select **Value Help**. A dialog shows up. 

    ![Value help display type](../images/extend-fiori-ui/value-help-dipslay-type.png)

10. In the **Define Value Help Properties for Urgency/Status** dialog:

    - Open the dropdown menu in the **Value Description Property** field and select **descr**
    - Open the dropdown menu for **Text Arrangement** and select **Text Only**
    - Choose **Apply**

    ![Value desc property](../images/extend-fiori-ui/value-desc-property.png)

11. Switch back to the app preview browser tab and open the filter fields. They now show the descriptive text instead of the code value.

### Edit columns

In the List Report, we can see the titles of the table columns shown as **customer_ID**, **urgency_code** and **status_code**. Furthermore, the column values are displaying the identifier and code values. We want to show a descriptive value instead.
 
![Reorder Columns](../images/extend-fiori-ui/table-code-values.png)

Let's start by rearranging the column order.

12. Select column **Title** and click **^** to move the column up to the top of the list.
13. Select column **status_code** and click **^** to place it before column **urgency_code**.

    ![Reorder Columns](../images/extend-fiori-ui/reorder-columns.png)

14.  Select the **Title** column. Field **Label** contains string **Title** which was automatically set during app generation. Click the **Globe** icon in the **Label** field to generate a translatable text key for it, and apply the changes.

15. For each of the columns **customer_ID**, **status_code** and **urgency_code**:
    - In the **Label** field, change the value to **Customer**, **Status**, and **Urgency**, respectively.
    - Choose the **Globe** icon in the **Label** field to generate a translatable text key.

    ![Update Columns](../images/extend-fiori-ui/update-columns.png)

16. We will now configure the **display text** and the **text arrangement** for columns **Customer**, **Status** and **Urgency** in order to show a descriptive text instead of the identifier/code.

    - Select column **Customer**
    - Click the drop-down box of property **Text** and select entry **customer/name**
    - Click the drop-down box of the now active property **Text Arrangement** and select **Text Only**
      
      ![Customer Column](../images/extend-fiori-ui/customer-column.png)

17.  Select text property for columns **Status** (select **status/descr** ) and **Urgency** (select **urgency/descr**) and also set **Text Arrangement** to **Text Only**
18.  Switch back to the app preview to see the effect.

### Configure the Table

When starting the app, per default the user has to press the
**Go** button in order to trigger the selection.\
This allows defining filters before the query is executed.\
The default behaviour can be changed in a way that selection is immediately
triggered when the app is started.

19. Select **Table** in the left pane of the page editor. In the **Initial Load** dropdown menu, select **Enabled** to load the data automatically.

    ![Enable Data Auto Load](../images/extend-fiori-ui/ls8.png)

It is considered as best practice providing a **criticality color** for status information displayed on the UI.

20. Select **Table** &rarr; **Columns** &rarr; **Status**. In the **Criticality** dropdown menu, select **status/criticality**.

    ![Add Status Criticality](../images/extend-fiori-ui/criticality.png)

### Check the result

21. The list page of the Incident Management application should look like this:

    ![Incident Management App's List Page](../images/extend-fiori-ui/IncidentsUI.png)

22. Navigate back to the page editor and choose **Page Map** in the top left. This takes you back to the overview of the **incidents** application.

    ![page-map-back](../images/extend-fiori-ui/page-map-back.png)

## Next Steps

[Configure the Object Page](configure-object-page.md)



