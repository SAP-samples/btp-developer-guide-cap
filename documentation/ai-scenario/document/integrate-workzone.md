# Integrate Your Application with SAP Build Work Zone, Standard Edition

Follow these steps to subscribe your application to the SAP Build Work Zone, standard edition.

## Prerequisite

Have your application deployed to SAP BTP, Cloud Foundry. See [Deploy in SAP BTP, Cloud Foundry Runtime](deploy-cf.md).

#### Update content

1. Open SAP Build Work Zone.

2. Choose **Channel Manager** from the left navigation bar. 

3. Choose the refresh icon to fetch the updated content.

    ![WorkZone1](../images/integrate-workzone/launchpad1.png)

#### Add the Application to the Content Explorer

1. Choose the **Content Manager** icon in the menu on the left and choose the **Content Explorer** button.

    ![WorkZone1](../images/integrate-workzone/content-explorer.png)

2. Choose the HTML5 Apps tile.

    ![WorkZone1](../images/integrate-workzone/html5_apps.png)

3. In the items table, select the application and choose **Add**.


![WorkZone1](../images/integrate-workzone/ce_checkbox.png)

#### Create a Group

1. Go back to the **Content Manager**, choose **Create** → **Group**.

    ![WorkZone1](../images/integrate-workzone/create_group.png)

2. Add a title using the pattern: `Incident Management Group <your-initials><unique-random-number>`. For example, the title is **Incident Management Group JD12**.

3. In the **Assignment Status** column, switch the slider on to assign the Incident-Management app to the group.

>[!Note]
> While switching the slider on, make sure you are selecting the application with the ID you have created.

4. Choose **Save**.
    
    ![WorkZone1](../images/integrate-workzone/group_enable.png)


#### Add Application to the Role Everyone

1. Back in the **Content Manager**, choose the **Everyone** role and then choose **Edit**.

    ![WorkZone1](../images/integrate-workzone/everyone.png)

2. In the **Assignment Status** column, switch the slider on to assign the Incident-Management app to the role.

3. Choose **Save**.

    ![WorkZone1](../images/integrate-workzone/everyone_enable.png)

#### Create a Site

1. Navigate to **Site Directory** and choose **Create Site**.

    ![WorkZone1](../images/integrate-workzone/create_site.png)

2. Enter the site name folling the pattern: `Incident Management Site <your-initials><unique-random-number>` and choose **Create**.

    ![WorkZone1](../images/integrate-workzone/create_site1.png)

3. Now, you are forwarded to your site.

#### Test Your Site

1. Navigate to the **Site Directory** and find your site.

    ![WorkZone1](../images/integrate-workzone/site_directory.png)

2. Choose **Go to site**.

    ![WorkZone1](../images/integrate-workzone/gotosite.png)

3. Choose the Incident Management application from the launch page.

    ![WorkZone1](../images/integrate-workzone/application_tile.png)

    You should be able to see the list report page.

    ![WorkZone1](../images/integrate-workzone/application.png)

## Next Step

Test the flow end to end by following the steps at [Test the Application End to End](e2e-testing-cf.md).



