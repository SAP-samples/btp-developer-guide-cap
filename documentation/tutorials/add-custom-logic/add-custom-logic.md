---
title: Add Custom Logic
description: This tutorial shows you how to add custom logic to the source code of the SAP Fiori elements application you have already created.
keywords: cap 
parser: v2
auto_validation: true
time: 10
tags: [ tutorial>beginner, software-product-function>sap-cloud-application-programming-model, programming-tool>node-js, programming-tool>java, software-product>sap-business-technology-platform, software-product>sap-fiori]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Svetoslav Pandeliev
author_profile: https://github.com/slavipande
---

## You will learn

- How to add custom code that changes the value of the **urgency** property.
- How CAP automatically treats the JavaScript/Java file that you add as a handler.

## Prerequisites

You've implemented the user interface of your application. Follow the steps in the [Add SAP Fiori Elements UIs](add-fiori-elements-uis) tutorial that is part of the [Develop a Full-Stack CAP Application Following SAP BTP Developer’s Guide](https://developers.sap.com/group.cap-application-full-stack.html) tutorial group.

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Add custom code

> You can create a CAP project in either Node.js or Java. You have to choose one way or the other and follow through. The tabs **Node.js** and **Java** provide detailed steps for each alternative way.

[OPTION BEGIN [Node.js]]

In this tutorial, you add some custom code to the CAP application. Depending on the contents of the **title** property, the custom code changes the value of the **urgency** property.

1. In SAP Business Application Studio, go to your **IncidentManagement** dev space.

    > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

2. Create a new **services.js** file in the **srv** folder of the **INCIDENT-MANAGEMENT** application.

3. Add the following code (the actual business logic) to the **services.js** file:

    ```js
    const cds = require('@sap/cds')

    class ProcessorService extends cds.ApplicationService {
      /** Registering custom event handlers */
      init() {
        this.before("UPDATE", "Incidents", (req) => this.onUpdate(req));
        this.before("CREATE", "Incidents", (req) => this.changeUrgencyDueToSubject(req.data));

        return super.init();
      }

      changeUrgencyDueToSubject(data) {
        let urgent = data.title?.match(/urgent/i)
        if (urgent) data.urgency_code = 'H'
      }

      /** Custom Validation */
      async onUpdate (req) {
        let closed = await SELECT.one(1) .from (req.subject) .where `status.code = 'C'`
        if (closed) req.reject `Can't modify a closed incident!`
      }
    }
    module.exports = { ProcessorService }
    ```

3. Make sure that the SAP Fiori application is running. If you closed it, choose the **Preview Application** option in the **Application Info - incidents** tab and select the **watch-incidents** npm script.

    > To open the **Application Info - incidents** tab: 
    >
    >1. Invoke the Command Palette - **View** &rarr; **Command Palette** or <kbd>Command</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for macOS / <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> for Windows. 
    >2. Choose **Fiori: Open Application Info**.


4. Create a new incident with the word **urgent** in its title and with the urgency set to **Medium**. 

    <!-- border; size:540px --> ![Create new incident](./create-new-incident.png)
    
    You see that the value in the **Urgency** field is automatically set to **high**.

    <!-- border; size:540px --> ![Fiori Elements Work List](./incidentapp.png)


[OPTION END]

[OPTION BEGIN [Java]]

In this tutorial, you add some custom code to the CAP application. Depending on the contents of the **title** property, the custom code changes the value of the **urgency** property.

1. In SAP Business Application Studio, go to your **IncidentManagement** dev space.

    > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

2. Create a new folder **handler** in the **srv/src/main/java/customer/incident_managеment** folder of your project. If **srv/src/main/java/customer/incident_managеment** doesn't exist, create it.

3. In the **handler** folder, create a new file **ProcessorServiceHandler.java**.

3. Add the following code (the actual business logic) to the **ProcessorServiceHandler.java** file:

    ```java
    package customer.incident_management.handler;

    import cds.gen.processorservice.Incidents;
    import cds.gen.processorservice.ProcessorService_;
    import cds.gen.sap.capire.incidents.*;
    import com.sap.cds.ql.Select;
    import com.sap.cds.services.ErrorStatuses;
    import com.sap.cds.services.ServiceException;
    import com.sap.cds.services.cds.CqnService;
    import com.sap.cds.services.handler.EventHandler;
    import com.sap.cds.services.handler.annotations.Before;
    import com.sap.cds.services.handler.annotations.ServiceName;
    import com.sap.cds.services.persistence.PersistenceService;
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import org.springframework.stereotype.Component;
    import java.util.List;
    import java.util.Locale;

    @Component
    @ServiceName(ProcessorService_.CDS_NAME)
    public class ProcessorServiceHandler implements EventHandler {
        private static final Logger logger = LoggerFactory.getLogger(ProcessorServiceHandler.class);
        private final PersistenceService db;
        public ProcessorServiceHandler(PersistenceService db) {
            this.db = db;
        }
        /*
        * Change the urgency of an incident to "high" if the title contains the word "urgent"
        */
        @Before(event = CqnService.EVENT_CREATE)
        public void ensureHighUrgencyForIncidentsWithUrgentInTitle(List<Incidents> incidents) {
            for (Incidents incident : incidents) {
                if (incident.getTitle().toLowerCase(Locale.ENGLISH).contains("urgent") &&
                        incident.getUrgencyCode() == null || !incident.getUrgencyCode().equals("H")) {
                    incident.setUrgencyCode("H");
                    logger.info("Adjusted Urgency for incident '{}' to 'HIGH'.", incident.getTitle());
                }
            }
        }
        /*
        * Handler to avoid updating a "closed" incident
        */
        @Before(event = CqnService.EVENT_UPDATE)
        public void ensureNoUpdateOnClosedIncidents(Incidents incident) {
            Incidents in = db.run(Select.from(Incidents_.class).where(i -> i.ID().eq(incident.getId()))).single(Incidents.class);
            if (in.getStatusCode().equals("C")) {
                throw new ServiceException(ErrorStatuses.CONFLICT, "Can't modify a closed incident");
            }
        }
    }
    ```

3. Make sure that the SAP Fiori application is running. If you closed it, navigate to the **srv** folder in the terminal and run `mvn cds:watch`.


4. Create a new incident with the word **urgent** in its title and with the urgency set to **Medium**. 

    <!-- border; size:540px --> ![Create new incident](./create-new-incident.png)
    
    You see that the value in the **Urgency** field is automatically set to **High**.

    <!-- border; size:540px --> ![Fiori Elements Work List](./incidentapp.png)

[OPTION END]

### Understand the custom code

[OPTION BEGIN [Node.js]]

Because your file is called **services.js** and has the same name as your application definition file **services.cds**, CAP automatically treats it as a handler file for the application defined in there. CAP exposes several [events](https://cap.cloud.sap/docs/node.js/events) and you can easily write handlers like the one mentioned earlier.

[OPTION END]

[OPTION BEGIN [Java]]

Because the Java class containing the custom code is annotated with `@ServiceName(ProcessorService_.CDS_NAME)`, CAP knows that any handler methods in the class are registered for events on entities defined in the **srv/services.cds** file.

The handler method itself is annotated with `@Before(event = CqnService.EVENT_CREATE, entity = Incidents_.CDS_NAME)`. This annotation means that the method is called before each **CREATE** event on the entity Incidents. CAP exposes several [events](https://cap.cloud.sap/docs/java/event-handlers/#phases) and you can easily write [handlers](https://cap.cloud.sap/docs/java/event-handlers/#handlerclasses) like the one mentioned earlier.

[OPTION END]

In this case, the event is triggered after a **READ** was carried out for the **Incidents** entity. In your custom handler, you get all the data (in this case, all the incidents) that was read according to the query. You can loop over each of them and, if needed, adjust the data of the response. In this case, you change the value of the **urgency** property when the **title** contains the word **urgent**. The new values for **Urgency** are then part of the response to the READ request.
