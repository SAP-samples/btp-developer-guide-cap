# Deploy in the SAP BTP, Cloud Foundry Runtime

## Ensure node_modules are installed
Run the `npm install` command in the following folders:
    - `gen/mtx/sidecar`
    - `root`
    - `app/incidents`

## Build the MTA file and Deploy to Cloud Foundry

Build and deploy the MTA file with the following command:

```sh
mbt build -t ./
cf deploy incident-management_1.0.0.mtar
```

## Next Step
[Subscribe to the Multitenant Application](./7-subscribe.md)
