# Run the Manager Dashboard in the Incident Management application

## Prerequisites

- You have sucessfully deployed the application to your SAP BTP Runtime.
- You have assigned application roles before accessing the application. See [User Role Assignment](https://developers.sap.com/tutorials/user-role-assignment.html).
- You have integrated your application with SAP Build Work Zone.

## Run and test the application

1. Access the `Incidents Management` application via launchpad.

2. Create a new incident as follows:

  ![New incident](./images/new-incident.png)

3. Select **Create** button.

4. Go back to the Home page and access the `Incident By Location` application via launchpad.

5. Cick on the `Bangalore` spot marker on the GeoMap where we suppose to have the **Stormy Weathers** customer.

  ![Select Spot Marker](./images/select-customer-location.png)

6. You will see your new incident with the creation date and marked as the one with low urgency. You can as well try the filter category buttons above to check how the filtering works.

  ![Result](./images/new-incident-in-manager-app.png)


## Summary

Congratulations! You have successfully created, deployed, and tested the freestyle SAPUI5 application.
