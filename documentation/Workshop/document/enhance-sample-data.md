# Enhance the Sample Data Using SAP Joule

## Prerequisites

You have created the data model using [Create entities](create-data-entities.md)

## Add the Sample Data
Data entities have been defined in previous step. Using SAP Joule let's create some sample data which can be used for local testing of our application.

1. Click on Joule icon. Start typing ```/cap``` in text box then choose **/cap-gen-data**. 

    ![gen-data](../images/enhance-sample-data/gen-data.png)

    > **Note:** By default **/cap-gen-data #db/schema.cds** should be displayed in text box.

    ![cap-gen-data](../images/enhance-sample-data/cap-gen-data-prompt.png)

2. Joule prompt will be prefield with **/cap-gen-data #db/schema.cds**, after that paste below prompt to generate sample data. 

```
Customers - Contains customer details such as ID, firstName, lastName, email, and phone. Addresses - Stores customer addresses with ID, customer_ID, city, postCode, and streetAddress. Incidents - Captures support incidents with fields ID, customer_ID, title, urgency_code, and status_code. Incident Conversations - Represents conversation history for each incident with unique ID, up__ID, timestamp, author, and message. Strictly check entry in ID column should not be duplicate. Consider ID column as primary key and to uniquely identify row generate ID column should be unique. Status - Defines incident status values with columns code, descr, and criticality. Status could be new(N), assigned(A), In Progress(I), on hold(H), resolved(R) and closed(C). Follow below example code - N, criticality - 1, descr - New. Create only column code, criticality and descr. Don't create name column. Urgency - Lists urgency levels with columns code and descr. Urgency code could be H, M and L. Urgency descr should be High, Medium and Low. Don't create name column. Ensure the generated sample data: Follows the given data format with appropriate relationships between entities. Includes realistic values for fields such as email, phone numbers, and messages. Uses meaningful incident titles and messages that reflect real-world support cases. Covers various urgency levels and statuses. The data should be structured in CSV format, maintaining consistency with SAP CAP standards.
```

3. Click on send icon.

    ![data-gen-prompt](../images/enhance-sample-data/data-gen-prompt.png)

4. Joule will create list of .csv files contains sample data as per schema provided. Click on **Accept** button.

    ![accept-gen-data](../images/enhance-sample-data/generated_files.png)

5. Under test/data folder of your project all generated csv files will be saved.

    ![validate-gen-data](../images/enhance-sample-data/validate-gen-data.png)

## Next Step

[Generate services](generate-service.md)