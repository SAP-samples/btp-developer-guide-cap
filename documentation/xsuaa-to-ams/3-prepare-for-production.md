# Prepare for Production
Now that the application is integrated with AMS, you need to prepare it for production deployment. This involves configuring the application to use IAS for authentication and AMS for authorization in a production environment.


## Add Production Configuration to Your CAP Application
In the following steps, you will modify the `package.json` to include production-specific configurations for IAS and AMS. 
1. Run the following command to add `ams`, `SAP Build Work Zone` and `HANA Cloud` configurations for the production profile in your `package.json`:

   ```shell
   cds add hana,workzone-standard --for production 
   ```
2. Install the added dependencies:

   ```shell
   npm i
   ```
The `package.json` should now contain the following configurations for the production profile:

```json
...
      "[production]": {
        "auth": "ias",
        "db": "hana",
        "destinations": true,
        "html5-repo": true
      },
      "workzone": true
    }
  }
```