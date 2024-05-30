
## Set Up Trace Collection

Traces allow you to analyze how a request, a message, or a task is being processed throughout your distributed system. To achieve this, `@cap-js/telemetry` wraps all essential functions of `cds.Service` and its derivates. For @cap-js databases (for example, `@cap-js/sqlite`), this includes `prepare()` and subsequent `stmt.run()`.


1. Open terminal at the root of your application and add the following dependencies:
    
    ```
      npm add @cap-js/telemetry@0.1.0 @opentelemetry/exporter-metrics-otlp-grpc @opentelemetry/exporter-trace-otlp-grpc @grpc/grpc-js
    ```
     > CAP provides custom metrics and traces using [@cap-js/telemetry](https://github.com/cap-js/telemetry) CDS plugin. 
     
2. Update the code of the `package.json` file with the following configuration:

   ```javascript
    .... 
    "cds": {
        "requires": {
     ....
            "[production]": {
                "telemetry": {
                    "kind": "to-cloud-logging" 
                }, 
            }
     ....
    ```
   > See [Predefined Kinds](https://github.com/cap-js/telemetry/?tab=readme-ov-file#predefined-kinds).

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


