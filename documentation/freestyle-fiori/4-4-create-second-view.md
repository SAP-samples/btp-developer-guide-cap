# Add the Second View

In this chapter, you'll add a second view with the navigation.

## Configure Routing in `manifest.json` File

1. Open `manifest.json` file from the `app/manager/webapp` folder.

2. Go to section `sap.ui5`/`routing`/`routes`.

3. Add the second route named `RouteSpotStatus` to the `routes` section with following content

```json
"routes": [
    ... ,
    {
    "name": "RouteSpotStatus",
    "pattern": "spot/{index}",
    "target": ["TargetSpotStatus"]
    }
]
```

A route is a way to address a specific part or state of an application with a specific URL hash pattern. The default route with empty pattern (or optional query as in this case) is what is displayed by default, the new route has the pattern spot/{index}, so a URL hash starting with "spot/" will trigger navigation to the target of this new route (target will be defined below). The path segment {index} in curly braces is variable and used to transport a value to the target, in this case which spot should be displayed in detail.

4. Scroll to the section below `sap.ui5`/`routing`/`targets`

5. Add a new entry to the targets configuration. This is the target of the newly added route and defines `SpotStatus` as the name of the view to display. It also defines the `viewLevel`, which helps routing to understand the navigation direction and displaying the correct transition animation. Add the corresponding `viewLevel` to the TargetMain. In total, the targets section now needs to look like this:

```json
"targets": {
    ... ,
    "TargetSpotStatus": {
        "viewId": "spotStatus",
        "viewName": "SpotStatus",
        "viewLevel": 2
    }
}
```
A target defines a view that is displayed, it can be referenced by one or more routes. Whenever a target is displayed, the corresponding view is loaded and shown in the app. The two targets point to the two content views which will be available in the application.

## Add the Second View

1. Create a new view file named `SpotStatus.view.xml` in the location `app/manager/webapp/view/SpotStatus.view.xml`.

2. Add the following content

```xml
<mvc:View
    displayBlock="true"
    controllerName="ns.manager.controller.SpotStatus"
    xmlns:mvc="sap.ui.core.mvc"
    xmlns:f="sap.f"
    xmlns:cssgrid="sap.ui.layout.cssgrid"
    xmlns:core="sap.ui.core"
    core:require="{
        util: 'ns/manager/format/util'
    }"
    xmlns="sap.m">
    <Page
        id="SpotStatusPage"
        title="{i18n>titleSpotStatus}"
        showNavButton="true"
        navButtonPress=".navToMain">
        <content>
            <IconTabBar id="iconTabBar" select=".onFilterSelect" class="sapUiResponsiveContentPadding">
                <items>
                    <IconTabFilter showAll="true" text="{i18n>msgFilterAll}" key="All"/>
                    <IconTabSeparator/>
                    <IconTabFilter icon="sap-icon://arrow-down" iconColor="Default" text="{i18n>msgFilterLow}" key="L"/>
                    <IconTabFilter icon="sap-icon://system-exit-2" iconColor="Critical" text="{i18n>msgFilterMedium}" key="M"/>
                    <IconTabFilter icon="sap-icon://warning" iconColor="Negative" text="{i18n>msgFilterHigh}" key="H"/>
                </items>
                <content>
                    <f:GridList id="incidentList"
                                items="{path: '/Incidents', sorter: {path:'status', group: true, descending: true}}"
                                noDataText="No incidents">
                                <f:customLayout>
                                    <cssgrid:GridBoxLayout boxesPerRowConfig="XL7 L4 M3 S1" />
                                </f:customLayout>
                        <f:items>
                            <f:GridListItem type="Active" highlight="{path: 'urgency', formatter:'util.formatHighlightColor'}">
                                <HBox justifyContent="SpaceBetween"
                                    class="sapUiSmallMargin">
                                    <VBox>
                                        <Title text="{title}" wrapping="true" />
                                        <Label text="{customer}" wrapping="true" />
                                        <Label text="{status}" wrapping="true" visible="false"/>
                                        <ObjectNumber
                                            unit="{path: 'createdAt', formatter: 'util.formatDaysAgo'}"/>
                                    </VBox>

                                    <Button
                                        id="BadgedButton"
                                        class="sapUiTinyMarginBeginEnd"
                                        icon="sap-icon://comment"
                                        type="Default"
                                        enabled="false">
                                        <customData>
                                            <BadgeCustomData
                                                key="badge"
                                                value="{comments}"
                                                visible="true"/>
                                        </customData>
                                    </Button>
                                </HBox>
                            </f:GridListItem>
                        </f:items>
                        <f:noData>
                            <IllustratedMessage enableVerticalResponsiveness="true" illustrationType="sapIllus-EmptyList"/>
                        </f:noData>
                    </f:GridList>
                </content>
            </IconTabBar>
        </content>
    </Page>
</mvc:View>
```

This view is also defined using the XML namespace **mvc**, indicating the use of the Model-View-Controller (MVC) pattern. The controller for this view is specified as `ns.manager.controller.SpotStatus`, indicating that the logic for this view is implemented in the SpotStatus controller within the **manager** namespace.

Namespaces for UI controls are declared. Here, namespaces for **sap.f** ([SAP Fiori Controls](https://sapui5.hana.ondemand.com/sdk/#/api/sap.f)), **sap.ui.layout.cssgrid** ([Flexible Grid Layout](https://experience.sap.com/fiori-design-web/flexible-grid/)), and **sap.ui.core** are declared. While **sap.ui.core** is required for the `require` utility, which can be used to import arbitrary modules. This utility enables the use of methods within these modules, such as `formatters`. 

Additionally, a custom namespace **util** is declared for custom utility functions, which are defined later in this tutorial.

Inside the view, there's a **Page** control. Its title is bound to a resource bundle using `{i18n>titleSpotStatus}`. It also has a navigation button that triggers the **navToMain** function when pressed.

Within the Page's content, there's an **[IconTabBar](https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.IconTabBar)** control. It represents a collection of tabs with associated content. The control contains several **[IconTabFilter](https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.IconTabFilter)** controls, each representing a filter option. The function called **onFilterSelect** is assigned as a handler for the **[select](https://sapui5.hana.ondemand.com/sdk/#/api/sap.m.IconTabBar%23events/select)** event which fires when an item is selected.

Inside the icon tab bar content, there's a **[GridList](https://sapui5.hana.ondemand.com/#/entity/sap.f.GridList)** control which represents a list-based control with grid layout capabilities. It displays a list of incidents from the default model. Each incident is represented by a **GridListItem**. The items are sorted based on the **status** property in descending order.

The **GridList** uses a custom layout defined by **[GridBoxLayout](https://sapui5.hana.ondemand.com/#/api/sap.ui.layout.cssgrid.GridBoxLayout%23methods/Summary)**, which specifies the number of boxes per row for extra large, large, medium and small screens. 

Inside each **GridListItem**, there are **[HBox](https://sapui5.hana.ondemand.com/sdk/#/api/sap.m.HBox)** and a **[VBox](https://sapui5.hana.ondemand.com/sdk/#/api/sap.m.VBox)** components representing a horizontal and vertical flexible box layouts, respectively. This contains various controls such as **Title**, **Label**, **ObjectNumber**, and a **Button**. These controls display information about each `incident`, including its title, customer name, status, and creation date. The **Button** is disabled and includes custom data with a badge representing the number of comments.

Some view properties are defined via [formatters](https://sapui5.hana.ondemand.com/sdk/#/topic/07e4b920f5734fd78fdaa236f26236d8.html). Formatters are used to define the formatting of data on the UI, while data types work in both directions: they format the data on the UI and parse and validate user input that is entered. You can either use standard formatters and data types or define your own custom objects. Here in the current view a color of every **GridListItem** is determined by the formatter function **formatHighlightColor** from the `utils` module (which will be added later). Similarly, the creation date of the incident is presented in the human-readable manner using the **formatDaysAgo** formatter.

If there are no incidents to display, an **[IllustratedMessage](https://sapui5.hana.ondemand.com/#/entity/sap.f.IllustratedMessage)** is shown with an empty list illustration.

## Add the Controller

1. Create a new view file named `SpotStatus.controller.ts` in the location `app/manager/webapp/controller/SpotStatus.controller.ts`.

2. Add the following content

```ts
import Controller from "sap/ui/core/mvc/Controller";
import UIComponent from "sap/ui/core/UIComponent";
import Filter from "sap/ui/model/Filter";
import FilterOperator from "sap/ui/model/FilterOperator";
import { IconTabBar$SelectEvent } from "sap/m/IconTabBar";
import IconTabBar from "sap/m/IconTabBar";
import ListBinding from "sap/ui/model/ListBinding";
import { Urgency } from "../format/util";
import { Route$MatchedEvent } from "sap/ui/core/routing/Route"; 

/**
 * @namespace ns.manager.controller
 */
export default class SpotStatus extends Controller {
    
    private defaultFilter: Filter;

    getUrgencyFilter(key: string): Filter[]{
        return (Object.values(Urgency) as Array<string>).includes(key) ? [new Filter("urgency", FilterOperator.EQ, key, false)] : [];
    }

    onFilterSelect(event: IconTabBar$SelectEvent): void {
        const key = event.getParameter("key");
        this.setFilter(key);
    }

    navToMain() {
        UIComponent.getRouterFor(this).navTo("RouteMain");
    }

    onInit() {
        const oRouter = (this.getOwnerComponent() as UIComponent)?.getRouter();
        oRouter.getRoute("RouteSpotStatus")!.attachMatched(this.onRouteMatched, this);
    }

    private onRouteMatched(event: Route$MatchedEvent): void {
        const oParameters: any = event.getParameters();
        const customerId = oParameters.arguments.index;
        this.defaultFilter = new Filter("customerID", FilterOperator.EQ, customerId, false);
        this.setFilter((this.getView()?.byId("iconTabBar") as IconTabBar)?.getSelectedKey());
    }

    private setFilter(key: string | undefined): void {
        let statusFilters: Filter[] = [];
        const listBinding = this.getView()?.byId("incidentList")?.getBinding("items") as ListBinding;      
        if (key) {
            statusFilters = this.getUrgencyFilter(key);
        }
        listBinding.filter([this.defaultFilter, ...statusFilters]);        
    }

}
```

The controller contains the following functions:

- **navToMain**: Navigates back to the main view via the **RouteMain** route.

- **onInit**: Lifecycle hook method called when the controller is initialized. It sets a handler for the **[routeMatched](https://sapui5.hana.ondemand.com/sdk/#/api/sap.ui.core.routing.Router%23events/Summary)** event. The **routeMatched** event is fired, when the current URL hash matches the pattern of the route or its subroutes.

- **onRouteMatched**: Event handler method called when the **RouteSpotStatus** route is matched. It retrieves the customer ID from the route parameters and adjusts the default filter accordingly (private class property **defaultFilter**). Then the default filter is used as the active one.

- **setFilter**: Sets the active filter for the list based on the selected key in the **IconTabBar**.

- **getUrgencyFilter**: Returns an array of **Filter** objects based on the provided key (urgency level).

- **onFilterSelect**: Event handler method triggered when an item is selected in the **IconTabBar** control. It sets the filter based on the selected key.

Overall, this controller gets the information of the routing by using **onRouteMatched** event. This data is stored as a default filter for the **Icon Tab Bar** component. Additional filters will be applied by clicking the corresponding **Icon Tab Filter**.

## Summary

You have successully created the second view, controller and the necessary routing.