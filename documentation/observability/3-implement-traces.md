
## Set Up Trace Collection

Traces allow you to analyze how a request, a message, or a task is being processed throughout your distributed system. To achieve this, `@cap-js/telemetry` wraps all essential functions of `cds.Service` and its derivates. For @cap-js databases (for example, `@cap-js/sqlite`), this includes `prepare()` and subsequent `stmt.run()`.

## Option 1: Configure the SAP BTP, Cloud Foundry Runtime Deployment

If you are deploying the application to SAP BTP, Cloud Foundry runtime, open terminal at the root of your application and add the following dependencies using the command:
    
```
cds add cloud-logging --with-telemetry
```

   > NOTE: CAP provides custom metrics and traces using [@cap-js/telemetry](https://github.com/cap-js/telemetry) CDS plugin. 
     
This adds the following dependencies and configurations to your application:

* In `package.json`:
    ```
    "dependencies": {
    
    "@cap-js/telemetry": ">=0",
    "@grpc/grpc-js": "^1",
    "@opentelemetry/exporter-metrics-otlp-grpc": "^0",
    "@opentelemetry/exporter-trace-otlp-grpc": "^0",
     "@opentelemetry/host-metrics": "^0",
    
    }

    ```
    
* In `mta.yaml`:
    
    ```
        modules:
        - name: incident-management-srv
          type: nodejs
          path: gen/srv
          requires:
            - name: incident-management-auth
            - name: incident-management-db
            - name: incident-management-cloud-logging # Added


       resources:
        - name: incident-management-cloud-logging  ## Cloud Logging Module Added
          type: org.cloudfoundry.managed-service
          parameters:
            service: cloud-logging
            service-plan: standard
            config:
              ingest_otlp:
                enabled: true
    ```

 See [Predefined Kinds](https://github.com/cap-js/telemetry/?tab=readme-ov-file#predefined-kinds).
 
   > NOTE: The versions of these dependencies can vary at the time you are running the above command. It is not necessary to match the version of these dependencies.

## Option 2: Configure the SAP BTP, Kyma Runtime Deployment

If you are deploying to the SAP BTP, Kyma runtime, follow these steps:

1. Open terminal at root of your application and add the following dependencies:

```sh
  npm add @cap-js/telemetry @opentelemetry/exporter-metrics-otlp-grpc @opentelemetry/exporter-trace-otlp-grpc @opentelemetry/host-metrics @grpc/grpc-js
```

> NOTE: Since [OpenTelemetry SDK 2.0](https://github.com/cap-js/telemetry?tab=readme-ov-file#welcome-to-cap-jstelemetry) is not yet supported with @cap-js/telemetry, update @opentelemetry/exporter-metrics-otlp-grpc and @opentelemetry/exporter-trace-otlp-grpc dependencies version to `0.57.2`. 

```
  ...
  "dependencies": {
    ...
    "@opentelemetry/exporter-metrics-otlp-grpc": "0.57.2",
    "@opentelemetry/exporter-trace-otlp-grpc": "0.57.2"
    ...
  },
...

```

2. Update the code of the `package.json` file with "telemetry": {"kind": "to-otlp"} as shown below:
  
  ```
    .... 
  "cds": {
      "requires": {
    ....
          "[production]": {
              "telemetry": {
                  "kind": "to-otlp" 
              }, 
          }
    ....
  ```
3. Delete the property `"telemetry":"to-cloud-logging"` from `package.json` if it is present.

## Run and Test Locally
Once the application has all the requried configurations. The application can be tested locally. 

1. In the terminal, run the application with the `cds watch` command.
2. Open the application and create an incident. 
3. Check the logs in the terminal:

    ```
    [telemetry] - elapsed times:
        0.00 →  95.53 =  95.53 ms  POST /odata/v4/processor/$batch
      10.07 →  92.64 =  82.56 ms    GET Incidents?$count=true&$filter=(IsActiveEntity%20eq%20false%20or%20SiblingEnt…
      35.54 →  55.97 =  20.43 ms      ProcessorService - READ ProcessorService.Incidents.drafts
      38.75 →  55.82 =  17.07 ms        db - READ ProcessorService.Incidents.drafts
      53.87 →  54.76 =   0.88 ms          @cap-js/sqlite - prepare SELECT json_insert('{}','$."HasActiveEntity"',CASE HasA…
      55.24 →  55.60 =   0.35 ms          @cap-js/sqlite - stmt.all SELECT json_insert('{}','$."HasActiveEntity"',CASE Has…
      56.92 →  71.60 =  14.68 ms      ProcessorService - READ ProcessorService.Incidents
      57.75 →  71.40 =  13.65 ms        db - READ ProcessorService.Incidents
      69.26 →  70.03 =   0.76 ms          @cap-js/sqlite - prepare SELECT json_insert('{}','$."ID"',ID,'$."title"',title,'…
      70.16 →  70.78 =   0.61 ms          @cap-js/sqlite - stmt.all SELECT json_insert('{}','$."ID"',ID,'$."title"',title,…
      72.21 →  74.65 =   2.43 ms      ProcessorService - READ ProcessorService.Incidents.drafts
      72.75 →  74.59 =   1.84 ms        db - READ ProcessorService.Incidents.drafts
      73.83 →  74.22 =   0.39 ms          @cap-js/sqlite - prepare SELECT json_insert('{}','$."ID"',ID) as _json_ FROM (SE…
      74.31 →  74.54 =   0.22 ms          @cap-js/sqlite - stmt.all SELECT json_insert('{}','$."ID"',ID) as _json_ FROM (S…
    ```
  

## Next Step  
[Set Up Metrics Collection](./metrics.md)


