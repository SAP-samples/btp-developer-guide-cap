# Introduction

SAP Fiori elements for OData V4 offers multiple ways to extend applications according to your specific requirements.

The **Flexible Programming Model** offers various options, allowing you to avoid a rigid choice between **SAP Fiori elements** and **freestyle SAPUI5** development. It provides the flexibility to use any SAPUI5 coding or controls within extension points, while also leveraging available building blocks and controller extensions to enhance applications. Additionally, it enables you to create custom applications that run on the SAP Fiori elements framework, where all pages can be treated as custom pages.

![Flexible Programming Model](./images/intro.jpg)

# Flexible Programming Model

In the following tutorials, you extend the Incident Management sample application using the Flexible Programming Model to showcase the **Extension Points** and the **Controller Extensions**.

## Extension Points: Custom Column

In the [Add Custom Column](./custom-column.md) tutorial, you extend the **Incidents** table in the **List Report** page with a custom column. This custom column is used to showcase the Micro Process Flow. The processor can use the  [MicroProcessFlow](https://sapui5.hana.ondemand.com/#/api/sap.suite.ui.commons.MicroProcessFlow) control to track the progress of an incident. 

![Custom Column](./images/intro-custom-column.png)

## Extension Points: Custom Header Facet

In the [Add Custom Header](./custom-header.md) tutorial, you extend header section in the **Object** page to add a custom header facet. This custom header facet shows the Micro Process Flow. The processor can use the  [MicroProcessFlow](https://sapui5.hana.ondemand.com/#/api/sap.suite.ui.commons.MicroProcessFlow) control to track the progress of an incident.

![Custom Header](./images/intro-custom-header.png)

## Extension Points: Custom Action

In the [Add Custom Action](./custom-action.md) tutorial, you add a custom action **Location** in the **Object** page. This custom action shows the location of the customer in a dialog using the [GeoMap](https://sapui5.hana.ondemand.com/#/api/sap.ui.vbm.GeoMap) control.

![Custom Action](./images/intro-custom-action.png)

## Extension Points: Custom Section

In the [Add Custom Section](./custom-section.md) tutorial, you add a custom section **Process Flow** in the **Object** page. This custom section shows the process flow of the incidents using the [ProcessFlow](https://sapui5.hana.ondemand.com/#/api/sap.suite.ui.commons.ProcessFlow) control.

![Custom Section](./images/intro-custom-section.png)

## Controller Extension

In the [Add Controller Extension](./controller-extension.md) tutorial, you add a controller extension to learn how to extend the SAP Fiori elements **Object** age controller and override the edit flow.

![Edit flow](./images/intro-edit-flow.png)
