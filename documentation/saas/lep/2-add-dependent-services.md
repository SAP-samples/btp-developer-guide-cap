# Add Dependent Services and Prepare for Production

## Activate SaaS Registry Dependencies

Some of the services your application consumes need to be registered as reuse services to work in multitenant environments. `@sap/cds-mtxs` offers an easy way to integrate these dependencies. It supports some services out of the box and also provides a simple API for plug-ins. See [SaaS Registry Dependencies](https://cap.cloud.sap/docs/guides/multitenancy/#saas-registry-dependencies).

Most notably, you will need such dependencies for the SAP Audit Log service, SAP Connectivity service, SAP Destination service, SAP HTML5 Application Repository service for SAP BTP, and SAP Cloud Portal service. All these services are supported natively and can be activated individually configuring them in the **cds.requires** file. In the most common case, you simply activate service dependencies like this:

1. Open `mtx/sidecar/package.json`. Add the following excerpt under the **cds.requires** section. 
> Delete "audit-log", "destinations" if they exist.

  ```json
  "requires": {
    "html5-host": true,
    "html5-runtime": true,
    "launchpad": {
      "vcap": {
        "label": "build-workzone-standard",
        "plan": "local-entry-point"
      },
      "subscriptionDependency": {
        "uaa": "xsappname"
      }
    }
  }
  ```
> [!Note]
> The launchpad `label` and `plan` should be the **Build Work Zone service name** and the **service plan** respectively.

2. Open `app/router/xs-app.json`, and replace the content with this one:

  ```json
  {
    "welcomeFile": "cp.portal/site",
    "routes": [
      {
        "source": "^(.*)$",
        "target": "$1",
        "service": "html5-apps-repo-rt",
        "authenticationType": "xsuaa"
      }
    ]
  } 
  ```

You are using the `SAP Build Workzone, HTML5 repo` as a reuse service. When subscribing, these services will be added as dependent services that can be used from the subscriber account. 

## Prepare for Deployment

1. Freeze the NPM dependencies for the server and MTX sidecar. See [Freeze Dependencies](https://cap.cloud.sap/docs/guides/deployment/to-cf#freeze-dependencies).

2. Go to the **root** of the application and run the following command:

```sh
npm i
npm update --package-lock-only
npm update --package-lock-only --prefix mtx/sidecar
```
## Next Step

[Prepare for Deployment in the SAP BTP, Cloud Foundry Runtime](./3-prepare-for-cf.md)
