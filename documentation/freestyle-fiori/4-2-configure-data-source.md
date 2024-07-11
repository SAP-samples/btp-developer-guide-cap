# Add dependencies, Import Data and Configure Data Source

In this chapter, you will add additional dependencies, import sample data and configure them as the data source.

## Add dependencies

In addition to the main SAPUI5 library `sap.m`, you will use other control libraries like `sap.ui.layout` and `sap.ui.vbm` in your application. The central point for configuring your SAPUI5 application is the `manifest.json` file, which is located at `manager/webapp/manifest.json`

1. Open `manifest.json` file

2. Go to the section `sap.ui5` and add the following libraries in `dependencies/libs` section

```json
    "dependencies": {
        ... ,
        "libs": {
          ... ,
          "sap.ui.layout": {},
          "sap.ui.vbm": {}
        }
      },
```

## Import Data

> In this exercise we assume that the geo data of the customers is stored separately in some other service. We mock the data in local JSON file for the simplicity reason. 

Add a local data source to the application and display the data on the further enhanced SAPUI5 view.

1. Right-click on the `manager/webapp/` folder and select **New Folder**.

2. Enter `localData` as the folder name and confirm by pressing **Enter**.

3. Right-click on the `localData` folder and select New File.

4. Enter `spots.json` as file name and confirm by pressing **Enter**.

5. Copy the following content into `spots.json`.

```json
{
  "spots": [
    {
      "pos": "8.641622;49.293696;0",
      "tooltip": "Walldorf, Germany",
      "label": "Walldorf",
      "customerID": "1004155"
    },
    {
      "pos": "77.714421;12.977788;0",
      "tooltip": "Bangalore, India",
      "label": "Bangalore",
      "customerID": "1004161"
    },
    {
      "pos": "-74.000380;40.753616;0",
      "tooltip": "New York, USA",
      "label": "New York",
      "customerID": "1004100"
    }
  ]
}
```

## Configure Data Source

After adding the spots data to your application, you'll need to configure the data source which provides the spots data.

1. Open `manifest.json` file.

2. Go to the section `sap.app`. Add a new **spotService** data source to the  **dataSources** section as follows:

```json
    "sap.app": {
        ... ,
        "dataSources": {
            ... ,
            "spotService": {
                "type": "JSON",
                "uri": "./localData/spots.json"
            }
        }
    }
```

3. Go to the section `sap.ui5`. Add a **spotModel** model to the **models** section as follows:

```json
"sap.ui5": {
  ... ,
  "models": {
    ... ,
    "spotModel":{
        "type": "sap.ui.model.json.JSONModel",
        "dataSource": "spotService",
        "preload": true
    }
  },
```

4. Since we does not use flexibility services, disable them by changing the first entry in the `sap.ui5` section as follows:

```json
    "sap.ui5": {
      "flexEnabled": false,
    ...
```

## Summary

You have successfully added required dependencies, sample data and the data source.