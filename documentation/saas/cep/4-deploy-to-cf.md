# Deploy in the SAP BTP, Cloud Foundry Runtime

## Build the Project

Run the following command to generate the `gen/` folder:

```sh
cds build --production
```

## Ensure node_modules are installed

Run the `npm install` command in the following folders:
- `gen/mtx/sidecar`
- `app/incidents`
- `root`

## Build the MTA File

Build the MTA file with the following command:

```sh
mbt build -t ./
```

## Deploy to Cloud Foundry

Deploy the generated `.mtar` file:

```sh
cf deploy <your-mtar-file>.mtar
```

## Next Step
[Subscribe to the Multitenant Application](./7-subscribe.md)
