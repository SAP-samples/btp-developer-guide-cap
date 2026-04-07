---
title: Add Test Cases
description: This tutorial shows you how to add basic tests cases in your application.
keywords: cap 
parser: v2
auto_validation: true
time: 30
tags: [ tutorial>beginner, software-product-function>sap-cloud-application-programming-model, programming-tool>node-js, programming-tool>java, software-product>sap-business-technology-platform, software-product>sap-fiori]
primary_tag: software-product-function>sap-cloud-application-programming-model
author_name: Svetoslav Pandeliev
author_profile: https://github.com/slavipande
---

## You will learn

- How to add dependencies.
- How to add tests.
- How to test the application.

## Prerequisites

You've configured the access to your application. Follow the steps in the [Add Authorization](add-authorization) tutorial that is part of the [Develop a Full-Stack CAP Application Following SAP BTP Developer’s Guide](https://developers.sap.com/group.cap-application-full-stack.html) tutorial group.

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Add dependencies

> You can create a CAP project in either Node.js or Java. You have to choose one way or the other and follow through. The tabs **Node.js** and **Java** provide detailed steps for each alternative way.

[OPTION BEGIN [Node.js]]

1. In SAP Business Application Studio, go to your **IncidentManagement** dev space.

    > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

2. From the root of the **INCIDENT-MANAGEMENT** project, choose the burger menu, and then choose **Terminal** &rarr; **New Terminal**.

3. To add the required dependencies, run the following command:

    ```bash
    npm add -D @cap-js/cds-test
    ```

[OPTION END]

[OPTION BEGIN [Java]]

1. In SAP Business Application Studio, go to your **IncidentManagement** dev space.

    > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

2. Open the **srv/pom.xml** file and add the following snippet to the dependencies section:

    ```xml
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>org.springframework.security</groupId>
        <artifactId>spring-security-test</artifactId>
        <scope>test</scope>	
    </dependency>
    ```


[OPTION END]

### Add tests

[OPTION BEGIN [Node.js]]

1. Create a folder at the root of the **INCIDENT-MANAGEMENT** project and name it **tests**.

2. In the **tests** folder, create the **test.js** file.

3. Add the following code to the **test.js** file:

    ```js
    const cds = require('@sap/cds/lib')
    const { default: axios } = require('axios')
    const { GET, POST, DELETE, PATCH, expect } = cds.test(__dirname + '../../')

    axios.defaults.auth = { username: 'alice' }

    jest.setTimeout(11111)

    describe('Test The GET Endpoints', () => {
      it('Should check Processor Service', async () => {
        const processorService = await cds.connect.to('ProcessorService')
        const { Incidents } = processorService.entities
        expect(await SELECT.from(Incidents)).to.have.length(4)
      })

      it('Should check Customers', async () => {
        const processorService = await cds.connect.to('ProcessorService')
        const { Customers } = processorService.entities
        expect(await SELECT.from(Customers)).to.have.length(3)
      })

      it('Test Expand Entity Endpoint', async () => {
        const { data } = await GET`/odata/v4/processor/Customers?$select=firstName&$expand=incidents`
        expect(data).to.be.an('object')
      })
    })

    describe('Draft Choreography APIs', () => {
      let draftId, incidentId

      it('Create an incident ', async () => {
        const { status, statusText, data } = await POST(`/odata/v4/processor/Incidents`, {
          title: 'Urgent attention required !',
          status_code: 'N'
        })
        draftId = data.ID
        expect(status).to.equal(201)
        expect(statusText).to.equal('Created')
      })

      it('+ Activate the draft & check Urgency code as H using custom logic', async () => {
        const response = await POST(
          `/odata/v4/processor/Incidents(ID=${draftId},IsActiveEntity=false)/ProcessorService.draftActivate`
        )
        expect(response.status).to.eql(201)
        expect(response.data.urgency_code).to.eql('H')
      })

      it('+ Test the incident status', async () => {
        const {
          status,
          data: { status_code, ID }
        } = await GET(`/odata/v4/processor/Incidents(ID=${draftId},IsActiveEntity=true)`)
        incidentId = ID
        expect(status).to.eql(200)
        expect(status_code).to.eql('N')
      })

      describe('Close Incident and Open it again to check Custom logic', () => {
        it(`Should Close the Incident-${draftId}`, async () => {
          const { status } = await POST(
            `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=true)/ProcessorService.draftEdit`,
            {
              PreserveChanges: true
            }
          )
          expect(status).to.equal(201)
        })
        it(`Should Close the Incident-${draftId}`, async () => {
          const { status } = await PATCH(`/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)`, {
            status_code: 'C'
          })
          expect(status).to.equal(200)
        })
        it('+ Activate the draft & check Status code as C using custom logic', async () => {
          const response = await POST(
            `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)/ProcessorService.draftActivate`
          )
          expect(response.status).to.eql(200)
        })
        it('+ Test the incident status to be closed', async () => {
          const {
            status,
            data: { status_code }
          } = await GET(`/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=true)`)
          expect(status).to.eql(200)
          expect(status_code).to.eql('C')
        })
        describe('should fail to re-open closed incident', () => {
          it(`Should Open Closed Incident-${draftId}`, async () => {
            const { status } = await POST(
              `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=true)/ProcessorService.draftEdit`,
              {
                PreserveChanges: true
              }
            )
            expect(status).to.equal(201)
          })
          it(`Should re-open the Incident-${draftId} but fail`, async () => {
            const { status } = await PATCH(`/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)`, {
              status_code: 'N'
            })
            expect(status).to.equal(200)
          })
          it(' `Should fail to activate draft trying to re-open the incidentt', async () => {
            try {
              const response = await POST(
                `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)/ProcessorService.draftActivate`
              )
            } catch (error) {
              expect(error.response.status).to.eql(500)
              expect(error.response.data.error.message).to.include(`Can't modify a closed incident`)
            }
          })
        })
      })
      it('- Delete the Draft', async () => {
        const response = await DELETE(`/odata/v4/processor/Incidents(ID=${draftId},IsActiveEntity=false)`)
        expect(response.status).to.eql(204)
      })
      it('- Delete the Incident', async () => {
        const response = await DELETE(`/odata/v4/processor/Incidents(ID=${draftId},IsActiveEntity=true)`)
        expect(response.status).to.eql(204)
      })
    })
    ```

    > With this code, you've added test cases in the application.

[OPTION END]

[OPTION BEGIN [Java]]

1. Create a new folder **test** in the **srv/src** directory.

2. In the **srv/src/test** folder, create the folder structure **java/customer/incident_management**.

2. In the **srv/src/test/java/customer/incident_management** folder, create a new file **IncidentsODataTests.java**.

3. Add the following code to the **IncidentsODataTests.java** file:

    ```java
    package customer.incident_management;

    import org.junit.jupiter.api.Test;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
    import org.springframework.boot.test.context.SpringBootTest;
    import org.springframework.security.test.context.support.WithMockUser;
    import org.springframework.test.web.servlet.MockMvc;
    import org.springframework.test.web.servlet.MvcResult;
    import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
    import static org.hamcrest.Matchers.hasSize;
    import com.jayway.jsonpath.JsonPath;
    import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
    import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
    import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

    @SpringBootTest
    @AutoConfigureMockMvc
    class IncidentsODataTests {
      
      private static final String incidentsURI = "/odata/v4/ProcessorService/Incidents";
        private static final String customerURI = "/odata/v4/ProcessorService/Customers";
        private static final String expandEntityURI = "/odata/v4/ProcessorService/Customers?$select=firstName&$expand=incidents";

        @Autowired
        private MockMvc mockMvc;

        /**
        * Test GET Api for Incidents
        * @throws Exception
        */
        @Test
        @WithMockUser(username = "alice")
        void incidentReturned(@Autowired MockMvc mockMvc) throws Exception {
            mockMvc.perform(get(incidentsURI))
                .andExpect(status().isOk())
                    .andExpect(jsonPath("$.value", hasSize(4)));

        }

        /**
        * Test GET Api for Customers
        * @throws Exception
        */
        @Test
        @WithMockUser(username = "alice")
        void customertReturned() throws Exception {
            mockMvc.perform(get(customerURI))
                .andExpect(status().isOk())
                    .andExpect(jsonPath("$.value", hasSize(3)));

        }

        /**
        * Test to ensure there is an Incident created by each Customer.
        * @throws Exception
        */

        @Test
        @WithMockUser(username = "alice")
        void expandEntityEndpoint() throws Exception {
            mockMvc.perform(get(expandEntityURI))
            .andExpect(jsonPath("$.value[0].incidents[0]").isMap())
            .andExpect(jsonPath("$.value[0].incidents[0]").isNotEmpty());

        }


        /**
        * Test for creating an Draft Incident
        * Activating the draft Incident and check Urgency code as H using custom logic
        * Delete the Incident
        */

        @Test
        @WithMockUser(username = "alice")
        void draftIncident() throws Exception {
            String incidentCreateJson = "{ \"title\": \"Urgent attention required!\", \"status_code\": \"N\",\"urgency_code\": \"M\"}";

                    /**
                      * Create a draft Incident
                      */

                    MvcResult createResult=  mockMvc.perform(MockMvcRequestBuilders.post("/odata/v4/ProcessorService/Incidents")
                    .content(incidentCreateJson)
                    .contentType("application/json")
                    .accept("application/json"))
                    .andExpect(status().isCreated())
                    .andExpect(jsonPath("$.title").value("Urgent attention required!"))
                    .andExpect(jsonPath("$.status_code").value("N"))
                    .andExpect(jsonPath("$.urgency_code").value("M"))
                    .andReturn();
    
                    String createResponseContent = createResult.getResponse().getContentAsString();
                    String ID = JsonPath.read(createResponseContent, "$.ID");
                    System.out.println("Incident ID : " + ID);
            
                    /**
                      * Activating the draft Incident
                      */

                    mockMvc.perform(MockMvcRequestBuilders.post("/odata/v4/ProcessorService/Incidents(ID="+ID+",IsActiveEntity=false)/ProcessorService.draftActivate")
                    .contentType("application/json")
                    .accept("application/json"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$").isMap())
                    .andExpect(jsonPath("$.title").value("Urgent attention required!"))
                    .andExpect(jsonPath("$.status_code").value("N"))
                    .andExpect(jsonPath("$.urgency_code").value("H"));  

                    /**
                    * Deleting an Incident
                    */

                    mockMvc.perform(MockMvcRequestBuilders.delete("/odata/v4/ProcessorService/Incidents(ID="+ID+",IsActiveEntity=true)"))
                    .andExpect(status().is(204));
        }


        /**
        * Test for creating an Active Incident
        * Test for closing the Active Incident
        * Test for custom handler ensuing prevent users from modifying a closed Incident
        */

        @Test
        @WithMockUser(username = "alice")
        void updateIncident() throws Exception {
            String incidentCreateJson = "{ \"title\": \"Urgent attention required!\", \"status_code\": \"N\", \"IsActiveEntity\": true }";
            String incidentUpdateJson = "{\"status_code\": \"C\"}";
            String closedIncidentUpdateJson = "{\"status_code\": \"I\"}";

            MvcResult createResult=  mockMvc.perform(MockMvcRequestBuilders.post("/odata/v4/ProcessorService/Incidents")
                    .content(incidentCreateJson)
                    .contentType("application/json")
                    .accept("application/json"))
                    .andExpect(status().isCreated())
                    .andExpect(jsonPath("$.title").value("Urgent attention required!"))
                    .andExpect(jsonPath("$.status_code").value("N"))
                    .andReturn();

                    String createResponseContent = createResult.getResponse().getContentAsString();
                    String ID = JsonPath.read(createResponseContent, "$.ID");
                    System.out.println("Incident ID : " + ID);
                    /**
                    * Closing an open Incident
                    */
                    MvcResult updateResult=  mockMvc.perform(MockMvcRequestBuilders.patch("/odata/v4/ProcessorService/Incidents(ID="+ID+",IsActiveEntity=true)")
                    .content(incidentUpdateJson)
                    .contentType("application/json")
                    .accept("application/json"))
                    .andExpect(status().isOk())
                    .andExpect(jsonPath("$.title").value("Urgent attention required!"))
                    .andExpect(jsonPath("$.status_code").value("C"))
                    .andReturn();

                    String updateResponseContent = updateResult.getResponse().getContentAsString();
                    String statusCode = JsonPath.read(updateResponseContent, "$.status_code");
                    System.out.println("status code : " + statusCode);

                    /**
                    * Updating a Closed Incident will throw an error with error message "Can't modify a closed incident"
                    */
                    mockMvc.perform(MockMvcRequestBuilders.patch("/odata/v4/ProcessorService/Incidents(ID="+ID+",IsActiveEntity=true)")
                    .content(closedIncidentUpdateJson)
                    .contentType("application/json")
                    .accept("application/json"))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.error.message").value("Can't modify a closed incident"));



        }

    }
    ```

    > With this code snippet, you've added test cases in the application.

[OPTION END]


### Test the application

[OPTION BEGIN [Node.js]]

1. Open the **package.json** file and add the `"test": "npx jest tests/test.js"` line inside the `scripts` section. This line adds a command to start the tests.

    ```json
    {
      "name": "incident-management",
      "version": "1.0.0",
      "description": "A simple CAP project.",
      "repository": "<Add your repository here>",
      "license": "UNLICENSED",
      "private": true,
      "dependencies": {
          ...
      },
      "devDependencies": {
          ...
      },
      "scripts": {
          "test": "npx jest tests/test.js",
          "start": "cds-serve",
          "watch-incidents": "cds watch --open incidents/webapp/index.html?sap-ui-xx-viewCache=false"
      },
      "cds": {
          ...
        }
      },
      ...
    }
    ```

2. To test the application, run the following command in the terminal:

    ```bash
    npm run test
    ```

3. When all the test cases pass, the output looks like this:

    ```bash
    PASS  tests/test.js
    Test The GET Endpoints
      ✓ Should check Processor Service (8 ms)
      ✓ Should check Customers (2 ms)
      ✓ Test Expand Entity Endpoint (55 ms)
    Draft Choreography APIs
      ✓ Create an incident  (31 ms)
      ✓ + Activate the draft & check Urgency code as H using custom logic (28 ms)
      ✓ + Test the incident status (16 ms)
      ✓ - Delete the incident (12 ms)
      Close incident and open it again to check Custom logic
        ✓ Should Close the incident-undefined (16 ms)
        ✓ Should Close the incident-undefined (13 ms)
        ✓ + Activate the draft & check Status code as C using custom logic (18 ms)
        ✓ + Test the incident status to be closed (9 ms)
        should fail to reopen closed incident
          ✓ Should open closed incident-undefined (14 ms)
          ✓ Should reopen the incident-undefined but fail (10 ms)
          ✓ Should fail to activate draft trying to reopen the incident (21 ms)

        Test Suites: 1 passed, 1 total
        Tests:       15 passed, 15 total
        Snapshots:   0 total
        Time:        2.028 s, estimated 7 s
        Ran all test suites.
    ```
   
    > For a more detailed guide, see [Testing](https://cap.cloud.sap/docs/node.js/cds-test) in the CAP Node.js SDK documentation.

[OPTION END]

[OPTION BEGIN [Java]]

1. To test the application, run the following command in the terminal:

    ```bash
    mvn verify
    ```

3. When all the test cases pass, the output looks like this:

    ```bash
    [INFO] Tests run: 5, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 15.28 s -- in com.sap.cap.incident_management.IncidentsODataTests
    [INFO] 
    [INFO] Results:
    [INFO] 
    [INFO] Tests run: 5, Failures: 0, Errors: 0, Skipped: 0
    [INFO] 
    [INFO] ------------------------------------------------------------------------
    ```
   
    > For a more detailed guide, see [Testing Applications](https://cap.cloud.sap/docs/java/developing-applications/testing#testing-cap-java-applications) in the CAP Java SDK documentation.

[OPTION END]