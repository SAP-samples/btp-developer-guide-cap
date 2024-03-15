# Implement Notifications Using SAP Alert Notification Service for SAP BTP

## [Prerequisites]((./mission-prerequisites/1-getting-started-with-alertnotification))
 
## Configure Your Application

1. To enable notifications, add this self-configuring plug-in package to your project:

   ```
   npm add @cap-js/notifications
   ```

2. Open the `srv` folder and create a file named `notification-types.json`. 


3. Paste the following code snippet in the `notification-types.json` file:

   ```json
   [
     {
       "NotificationTypeKey": "IncidentResolved",
       "NotificationTypeVersion": "1",
       "Templates": [
         {
           "Language": "en",
           "TemplatePublic": "Incident Resolved",
           "TemplateSensitive": "Incident '{{title}}' Resolved",
           "TemplateGrouped": "Incident Status Update",
           "TemplateLanguage": "mustache",
           "Subtitle": "Incident from '{{customer}}' resolved by {{user}}."
         }
       ]
     }
   ]
   ```

   > Here are the default plug-in configurations:
   >
   > ```notifications: {
   > impl: '@cap-js/notifications/srv/notifyToConsole',
   > prefix: '$app-name',
   > types: 'srv/notification-types.json',
   > outbox: true,
   > kind: 'notify-to-console'
   > },
   > ```
   >
   > As a developer, if you'd like to store types somewhere else, you should update the `cds.requires.notifications.types` property as well.

3. Open the file `processor-service.js`.

4. Replace the code with following code:

   ```js
   const cds = require("@sap/cds");

   class ProcessorService extends cds.ApplicationService {
     /** Registering custom event handlers */
     async init() {
       const { Incidents } = this.entities;

       this.before("UPDATE", "Incidents", (req) => this.onUpdate(req));
       this.before("CREATE", "Incidents", (req) =>
         this.changeUrgencyDueToSubject(req.data)
       );
       this.after("UPDATE", Incidents, async (incident) =>
         this.sendIncidentClosedNotification(incident)
       );
       this.after("CREATE", Incidents, async (incident) =>
         this.sendCreationNotification(incident)
       );
       return super.init();
     }
     // Triggering Notification on incident creation
     async sendCreationNotification(incident) {
       let [customer, supporters] = await Promise.all([
         this.getCustomers(incident),
         this.incidentSupporters(incident),
       ]);
       // Usage of the notification service in CAP
       const alert = await cds.connect.to("notifications");

       //You can use the following signature to send the simple notification with title and description

       await alert.notify({
         recipients: supporters,
         priority: { H: "HIGH", L: "LOW" }[incident.urgency_code],
         title: `New incident created by ${customer.info}`,
         description: incident.title,
       });
       /*
   - priority - Priority of the notification, this argument is optional, it defaults to NEUTRAL
   - description - Subtitle for the notification, this argument is optional
   
   */
     }
     //returns the logged in user(mocking the incident support person)
     incidentSupporters() {
       return [cds.context.user.id];
     }

     /*
   Send a notification using a pre-defined template when an incident is resolved.
   */
     async sendIncidentClosedNotification(incident) {
       if (incident.status_code === "C") {
         const alert = await cds.connect.to("notifications");
         let customer = await this.getCustomers(incident);
         await alert.notify("IncidentResolved", {
           recipients: [cds.context.user.id],
           data: {
             customer: customer.info,
             title: incident.title,
             user: cds.context.user.id,
           },
         });
       }
     }
     async getCustomers(incident) {
       const { Customers } = this.entities;
       let customer = await SELECT.from(
         Customers,
         incident.customer_ID,
         (c) => {
           c.firstName, c.lastName, c.email;
         }
       );
       customer.info = `${customer.firstName} ${customer.lastName} (${customer.email})`;
       customer.id = cds.context.user.id; // Fake customer id for demo purposes only
       return customer;
     }
     changeUrgencyDueToSubject(data) {
       if (data) {
         const incidents = Array.isArray(data) ? data : [data];
         incidents.forEach((incident) => {
           if (incident.title?.toLowerCase().includes("urgent")) {
             incident.urgency = { code: "H", descr: "High" };
           }
         });
       }
     }

     /** Custom Validation */
     async onUpdate(req) {
       const { status_code } = await SELECT.one(
         req.subject,
         (i) => i.status_code
       ).where({ ID: req.data.ID });
       if (status_code === "C")
         return req.reject(`Can't modify a closed incident`);
     }
   }
   module.exports = ProcessorService;
   ```

## Test Locally

Now that the configuration is done, the application can be tested locally.

1. Run `cds watch` in your terminal.

2. Open the application and log in:

  username: `alice`
  password: none

3. Create a new incident in the application.

  You should see the following logs in the terminal:

   ```sh
        [cds] - connect to notifications > notify-to-console

        ---------------------------------------------------------------
        Notification: Default {
        NotificationTypeKey: 'Default',
        NotificationTypeVersion: '1',
        Priority: 'NEUTRAL',
        Properties: [
            {
            Key: 'title',
            Language: 'en',
            Value: 'New incident created by Daniel Watts (daniel.watts@demo.com)',
            Type: 'String',
            IsSensitive: false
            },
            {
            Key: 'description',
            Language: 'en',
            Value: 'Motorcycle broke',
            Type: 'String',
            IsSensitive: false
            }
        ],
        Recipients: [ { RecipientId: 'alice' } ]
        }
        ---------------------------------------------------------------

   ```

5. Open the newly created incident and change the status to `Closed`.

6. Check the logs again:

   ```sh
        ---------------------------------------------------------------
        Notification: IncidentResolved {
        NotificationTypeKey: 'incident-management/IncidentResolved',
        Recipients: [ { RecipientId: 'alice' } ],
        Priority: 'NEUTRAL',
        Properties: [
            {
            Key: 'customer',
            Value: 'Daniel Watts (daniel.watts@demo.com)',
            Language: 'en',
            Type: 'string'
            },
            {
            Key: 'title',
            Value: 'Motorcycle broke',
            Language: 'en',
            Type: 'string'
            },
            { Key: 'user', Value: 'alice', Language: 'en', Type: 'string' }
        ],
        NotificationTypeVersion: '1'
        }

   ```

   > This log is generated by the custom notification type defined in the `src/notification-types.json`
   > Read more about [Use Notification Types](src/notification-types.jsonhttps://github.com/cap-js/notifications?tab=readme-ov-file#use-notification-types)

You have prepared the application for deployment.
