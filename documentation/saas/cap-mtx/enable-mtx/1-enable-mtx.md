# Enable Multitenancy for the CAP Application

The `@sap/cds-mtxs` package provides a set of SAP Cloud Application Programming Model (CAP) services which implement multitenancy, features toggles and extensibility, also called 'MTX'. Read more about [`@sap/cds-mtxs`](https://www.npmjs.com/package/@sap/cds-mtxs) at the npm documentation.
MTX services are implemented in Node.js and can run in the same Node.js server as your application services or in a separate micro services called **sidecars**. All services can be consumed via REST APIs.

1. Run the `@sap/cds-mtxs` package to enable multitenancy for the Incident Management application:

    ```shell
    cds add multitenancy --for production
    ```
2. Install your application dependencies:

    ```shell
    npm i
    ```

This command adds configuration for the SAP Software-as-a-Service Provisioning service, mtx-sidecar in the mta.yaml file.
The tenant mode in `XSUAA` is also changed from `dedicated` to `shared`. 
> **TIP:** The above comment is only valid if the project has a MTA already.










