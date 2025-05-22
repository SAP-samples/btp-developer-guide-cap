# Add Dependent Services and Prepare for Production

## SaaS Registry Dependencies

Some of the services your application consumes need to be registered as reuse services to work in multitenant environments. `@sap/cds-mtxs` offers an easy way to integrate these dependencies. It supports some services out of the box and also provides a simple API for plug-ins. See[SaaS Registry Dependencies](https://cap.cloud.sap/docs/guides/multitenancy/#saas-registry-dependencies).

Most notably, you will need such dependencies for the SAP Audit Log service, SAP Connectivity service, SAP Destination service, SAP HTML5 Application Repository service for SAP BTP, and SAP Cloud Portal service. All these services are supported natively and can be activated individually configuring them in the cds.requires file. In the most common case, you simply activate service dependencies like this:

1. At the root of your project, run the command `cds add workzone`
2. From `mtx/sidecar/package.json`, remove `"html5-repo": true`, `"destination": true`.
3. Install the required dependencies inside the `mtx/sidecar` module.
```sh
cd mtx/sidecar
npm install @sap/xsenv
```
The `mtx/sidecar/package.json` should have configuration like the following for dependencies:
```json
...
  "cds": {
    "profile": "mtx-sidecar",
    "requires": {
      "html5-host": true
    }
  }
...
```

You are using the `html5 repo host` reuse service. When subscribing, these services will be added as dependent services that can be used from the subscriber account. 

## Prepare for Deployment

1. Freeze the npm dependencies for the server and MTX sidecar. See [Freeze Dependencies](https://cap.cloud.sap/docs/guides/deployment/to-cf#freeze-dependencies).

2. Go to the **root** of the application and run the following command:

```sh
npm update --package-lock-only
npm update --package-lock-only --prefix mtx/sidecar
```
