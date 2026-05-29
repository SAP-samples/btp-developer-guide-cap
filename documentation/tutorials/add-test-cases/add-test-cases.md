## Add Test Cases

In this tutorial, you learn how to add dependencies, how to add tests, and how to test the application.

## Prerequisites

You've configured the access to your application. Follow the steps in the [Add Authorization](add-authorization) tutorial that is part of the [Develop a Full-Stack CAP Application Following SAP BTP Developer's Guide](https://developers.sap.com/group.cap-application-full-stack.html) tutorial group.

> This tutorial follows the guidance provided in the [SAP BTP Developer's Guide](https://help.sap.com/docs/btp/btp-developers-guide/what-is-btp-developers-guide).

### Add dependencies

<details open>
<summary>Node.js dependencies</summary>

1. In SAP Business Application Studio, go to your **IncidentManagement** dev space.

    > Make sure the **IncidentManagement** dev space is in status **RUNNING**.

2. From the root of the **INCIDENT-MANAGEMENT** project, choose the burger menu, and then choose **Terminal** &rarr; **New Terminal**.

3. To add the required dependencies, run the following command:

    ```bash
    npm add -D @cap-js/cds-test jest
    ```

    | Package | Role |
    |---|---|
    | `@cap-js/cds-test` | CAP test helper — HTTP client, `expect`, server lifecycle |
    | `jest` | Test runner |

</details>

<details>
<summary>Java dependencies</summary>

Open the **srv/pom.xml** file and add the following snippet to the dependencies section:

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

</details>

### Add tests

<details open>
<summary>Node.js test cases (test.js)</summary>

1. Create a folder at the root of the **INCIDENT-MANAGEMENT** project and name it **test**.

2. In the **test** folder, create the **test.js** file.

3. Add the following code to the **test.js** file:

    ```js
    const cds = require('@sap/cds')
    const test = cds.test(__dirname + '/..')
    const { GET, POST, DELETE, PATCH, expect } = test

    test.defaults.auth = { username: 'alice', password: '' }

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
        expect(data.value).to.be.an('array')
      })
    })

    describe('Draft Choreography APIs', () => {
      let draftId, incidentId

      it('Create an incident ', async () => {
        const { status, data } = await POST(`/odata/v4/processor/Incidents`, {
          title: 'Urgent attention required !',
          status_code: 'N'
        })
        draftId = data.ID
        expect(status).to.equal(201)
        expect(data.IsActiveEntity).to.equal(false)
      })

      it('+ Activate the draft & check Urgency code as H using custom logic', async () => {
        const { status, data } = await POST(
          `/odata/v4/processor/Incidents(ID=${draftId},IsActiveEntity=false)/ProcessorService.draftActivate`
        )
        expect(status).to.eql(201)
        expect(data.urgency_code).to.eql('H')
        expect(data.IsActiveEntity).to.equal(true)
      })

      it('+ Test the incident status', async () => {
        const { status, data: { status_code, ID } } = await GET(
          `/odata/v4/processor/Incidents(ID=${draftId},IsActiveEntity=true)`
        )
        incidentId = ID
        expect(status).to.eql(200)
        expect(status_code).to.eql('N')
      })

      describe('Close Incident and Open it again to check Custom logic', () => {
        it('Should Close the Incident', async () => {
          const { status } = await POST(
            `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=true)/ProcessorService.draftEdit`,
            { PreserveChanges: true }
          )
          expect(status).to.equal(201)
        })

        it('Should patch the Incident status to Closed', async () => {
          const { status } = await PATCH(
            `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)`,
            { status_code: 'C' }
          )
          expect(status).to.equal(200)
        })

        it('+ Activate the draft & check Status code as C using custom logic', async () => {
          const { status, data } = await POST(
            `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)/ProcessorService.draftActivate`
          )
          expect(status).to.eql(200)
          expect(data.status_code).to.eql('C')
        })

        it('+ Test the incident status to be closed', async () => {
          const { status, data: { status_code } } = await GET(
            `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=true)`
          )
          expect(status).to.eql(200)
          expect(status_code).to.eql('C')
        })

        describe('should fail to re-open closed incident', () => {
          it('Should Open Closed Incident', async () => {
            const { status } = await POST(
              `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=true)/ProcessorService.draftEdit`,
              { PreserveChanges: true }
            )
            expect(status).to.equal(201)
          })

          it('Should re-open the Incident but fail', async () => {
            const { status } = await PATCH(
              `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)`,
              { status_code: 'N' }
            )
            expect(status).to.equal(200)
          })

          it('Should fail to activate draft trying to re-open the incident', async () => {
            const { status, data } = await POST(
              `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)/ProcessorService.draftActivate`,
              {},
              { validateStatus: null }
            )
            expect(status).to.eql(500)
            expect(data.error.message).to.include(`Can't modify a closed incident`)
          })
        })
      })

      it('- Delete the Draft', async () => {
        const { status } = await DELETE(
          `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=false)`
        )
        expect(status).to.eql(204)
      })

      it('- Delete the Incident', async () => {
        const { status } = await DELETE(
          `/odata/v4/processor/Incidents(ID=${incidentId},IsActiveEntity=true)`
        )
        expect(status).to.eql(204)
      })
    })

    describe('Auto-Urgency logic (processor-service.js custom handler)', () => {
      const activate = async (body) => {
        const { data: draft } = await POST(`/odata/v4/processor/Incidents`, body)
        const { data: active } = await POST(
          `/odata/v4/processor/Incidents(ID=${draft.ID},IsActiveEntity=false)/ProcessorService.draftActivate`
        )
        return active
      }
      const cleanup = async (id) => {
        await DELETE(`/odata/v4/processor/Incidents(ID=${id},IsActiveEntity=true)`, { validateStatus: null })
      }

      it('does NOT change urgency_code when title has no "urgent"', async () => {
        const active = await activate({ title: 'Routine maintenance', urgency_code: 'L', status_code: 'N' })
        expect(active.urgency_code).to.equal('L')
        await cleanup(active.ID)
      })

      it('sets urgency_code=H for all-caps URGENT (case-insensitive /urgent/i)', async () => {
        const active = await activate({ title: 'URGENT: system failure', urgency_code: 'L', status_code: 'N' })
        expect(active.urgency_code).to.equal('H')
        await cleanup(active.ID)
      })

      it('sets urgency_code=H when "urgent" appears mid-title', async () => {
        const active = await activate({ title: 'Please treat this as urgent matter', urgency_code: 'M', status_code: 'N' })
        expect(active.urgency_code).to.equal('H')
        await cleanup(active.ID)
      })
    })

    describe('Authorization', () => {
      it('rejects support-role user (alice) from AdminService with 403', async () => {
        const { status } = await GET(`/odata/v4/admin/Customers`, { validateStatus: null })
        expect(status).to.equal(403)
      })

      it('allows carol (admin role) to read and write Customers', async () => {
        const carol = { auth: { username: 'carol', password: '' } }

        const { status: gs, data } = await GET(`/odata/v4/admin/Customers`, carol)
        expect(gs).to.equal(200)
        expect(data.value).to.be.an('array')

        const { status: cs } = await POST(
          `/odata/v4/admin/Customers`,
          { ID: 'AUTH01', firstName: 'Test', lastName: 'Admin' },
          carol
        )
        expect(cs).to.equal(201)

        const { status: ds } = await DELETE(`/odata/v4/admin/Customers('AUTH01')`, { ...carol, validateStatus: null })
        expect(ds).to.equal(204)
      })
    })
    ```

    > With this code, you've added test cases in the application.

</details>

<details>
<summary>Java test cases (IncidentsODataTests.java)</summary>

1. Create a new folder **test** in the **srv/src** directory.

2. In the **srv/src/test** folder, create the folder structure **java/customer/incident_management**.

3. In the **srv/src/test/java/customer/incident_management** folder, create a new file **IncidentsODataTests.java**.

4. Add the following code to the **IncidentsODataTests.java** file:

```java
package customer.incident_management;

import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestMethodOrder;
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
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class IncidentsODataTests {

    private static final String incidentsURI = "/odata/v4/ProcessorService/Incidents";
    private static final String customerURI = "/odata/v4/ProcessorService/Customers";
    private static final String expandEntityURI = "/odata/v4/ProcessorService/Customers?$select=firstName&$expand=incidents";
    private static final String adminCustomerURI = "/odata/v4/AdminService/Customers";

    @Autowired
    private MockMvc mockMvc;

    private String draftId;
    private String incidentId;

    // -- GET Endpoints

    @Test @Order(1) @WithMockUser(username = "alice")
    void shouldCheckProcessorService() throws Exception {
        mockMvc.perform(get(incidentsURI))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.value", hasSize(4)));
    }

    @Test @Order(2) @WithMockUser(username = "alice")
    void shouldCheckCustomers() throws Exception {
        mockMvc.perform(get(customerURI))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.value", hasSize(3)));
    }

    @Test @Order(3) @WithMockUser(username = "alice")
    void testExpandEntityEndpoint() throws Exception {
        mockMvc.perform(get(expandEntityURI))
            .andExpect(jsonPath("$.value[0].incidents[0]").isMap())
            .andExpect(jsonPath("$.value[0].incidents[0]").isNotEmpty());
    }

    // -- Draft Choreography APIs

    @Test @Order(4) @WithMockUser(username = "alice")
    void createAnIncident() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI)
            .content("{ \"title\": \"Urgent attention required !\", \"status_code\": \"N\" }")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isCreated())
            .andReturn();
        draftId = JsonPath.read(result.getResponse().getContentAsString(), "$.ID");
        incidentId = draftId;
    }

    @Test @Order(5) @WithMockUser(username = "alice")
    void activateDraftAndCheckUrgencyH() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI+"(ID="+draftId+",IsActiveEntity=false)/ProcessorService.draftActivate")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.urgency_code").value("H"));
    }

    @Test @Order(6) @WithMockUser(username = "alice")
    void testIncidentStatus() throws Exception {
        mockMvc.perform(get(incidentsURI+"(ID="+incidentId+",IsActiveEntity=true)"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.status_code").value("N"));
    }

    @Test @Order(7) @WithMockUser(username = "alice")
    void shouldCloseTheIncident() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI+"(ID="+incidentId+",IsActiveEntity=true)/ProcessorService.draftEdit")
            .content("{ \"PreserveChanges\": true }")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isOk());
    }

    @Test @Order(8) @WithMockUser(username = "alice")
    void shouldPatchIncidentStatusToClosed() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.patch(incidentsURI+"(ID="+incidentId+",IsActiveEntity=false)")
            .content("{\"status_code\": \"C\"}")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isOk());
    }

    @Test @Order(9) @WithMockUser(username = "alice")
    void activateDraftAndCheckStatusC() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI+"(ID="+incidentId+",IsActiveEntity=false)/ProcessorService.draftActivate")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.status_code").value("C"));
    }

    @Test @Order(10) @WithMockUser(username = "alice")
    void testIncidentStatusToBeClosed() throws Exception {
        mockMvc.perform(get(incidentsURI+"(ID="+incidentId+",IsActiveEntity=true)"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.status_code").value("C"));
    }

    @Test @Order(11) @WithMockUser(username = "alice")
    void shouldOpenClosedIncident() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI+"(ID="+incidentId+",IsActiveEntity=true)/ProcessorService.draftEdit")
            .content("{ \"PreserveChanges\": true }")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isOk());
    }

    @Test @Order(12) @WithMockUser(username = "alice")
    void shouldReOpenTheIncidentButFail() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.patch(incidentsURI+"(ID="+incidentId+",IsActiveEntity=false)")
            .content("{\"status_code\": \"N\"}")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isOk());
    }

    @Test @Order(13) @WithMockUser(username = "alice")
    void shouldFailToActivateDraftTryingToReOpenIncident() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI+"(ID="+incidentId+",IsActiveEntity=false)/ProcessorService.draftActivate")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isConflict())
            .andExpect(jsonPath("$.error.message").value("Can't modify a closed incident"));
    }

    @Test @Order(14) @WithMockUser(username = "alice")
    void deleteTheDraft() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.delete(incidentsURI+"(ID="+incidentId+",IsActiveEntity=false)"))
            .andExpect(status().is(204));
    }

    @Test @Order(15) @WithMockUser(username = "alice")
    void deleteTheIncident() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.delete(incidentsURI+"(ID="+incidentId+",IsActiveEntity=true)"))
            .andExpect(status().is(204));
    }

    // -- Auto-Urgency logic

    @Test @Order(16) @WithMockUser(username = "alice")
    void doesNotChangeUrgencyForNonUrgentTitle() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI)
            .content("{ \"title\": \"Routine maintenance\", \"urgency_code\": \"L\", \"status_code\": \"N\" }")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isCreated())
            .andReturn();
        String id = JsonPath.read(result.getResponse().getContentAsString(), "$.ID");

        mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI+"(ID="+id+",IsActiveEntity=false)/ProcessorService.draftActivate")
            .contentType("application/json").accept("application/json"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.urgency_code").value("L"));

        mockMvc.perform(MockMvcRequestBuilders.delete(incidentsURI+"(ID="+id+",IsActiveEntity=true)"))
            .andExpect(status().is(204));
    }

    @Test @Order(17) @WithMockUser(username = "alice")
    void setsUrgencyHForAllCapsUrgentTitle() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI)
            .content("{ \"title\": \"URGENT: system failure\", \"urgency_code\": \"L\", \"status_code\": \"N\" }")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isCreated())
            .andReturn();
        String id = JsonPath.read(result.getResponse().getContentAsString(), "$.ID");

        mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI+"(ID="+id+",IsActiveEntity=false)/ProcessorService.draftActivate")
            .contentType("application/json").accept("application/json"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.urgency_code").value("H"));

        mockMvc.perform(MockMvcRequestBuilders.delete(incidentsURI+"(ID="+id+",IsActiveEntity=true)"))
            .andExpect(status().is(204));
    }

    @Test @Order(18) @WithMockUser(username = "alice")
    void setsUrgencyHForUrgentInMidTitle() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI)
            .content("{ \"title\": \"Please treat this as urgent matter\", \"urgency_code\": \"M\", \"status_code\": \"N\" }")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isCreated())
            .andReturn();
        String id = JsonPath.read(result.getResponse().getContentAsString(), "$.ID");

        mockMvc.perform(MockMvcRequestBuilders.post(incidentsURI+"(ID="+id+",IsActiveEntity=false)/ProcessorService.draftActivate")
            .contentType("application/json").accept("application/json"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.urgency_code").value("H"));

        mockMvc.perform(MockMvcRequestBuilders.delete(incidentsURI+"(ID="+id+",IsActiveEntity=true)"))
            .andExpect(status().is(204));
    }

    // -- Authorization

    @Test @Order(19) @WithMockUser(username = "alice")
    void rejectsSupportRoleUserFromAdminServiceWith403() throws Exception {
        mockMvc.perform(get(adminCustomerURI))
            .andExpect(status().isForbidden());
    }

    @Test @Order(20) @WithMockUser(username = "carol")
    void allowsAdminRoleUserToReadAndWriteCustomers() throws Exception {
        mockMvc.perform(get(adminCustomerURI))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.value").isArray());

        mockMvc.perform(MockMvcRequestBuilders.post(adminCustomerURI)
            .content("{ \"ID\": \"AUTH01\", \"firstName\": \"Test\", \"lastName\": \"Admin\" }")
            .contentType("application/json")
            .accept("application/json"))
            .andExpect(status().isCreated());

        mockMvc.perform(MockMvcRequestBuilders.delete(adminCustomerURI+"('AUTH01')"))
            .andExpect(status().is(204));
    }
}
```

> With this code snippet, you've added test cases in the application.

</details>

### Test the application

<details open>
<summary>Node.js: test and verify</summary>

#### 1. Add test users to package.json

The test suite includes Authorization tests that check role-based access. These tests need three users — `alice` and `bob` with the `support` role (for `ProcessorService`), and `carol` with the `admin` role (for `AdminService`).

Open **package.json** and add the `cds.requires` block below. If the block already exists from the [Add Authorization](add-authorization) tutorial, just make sure `carol` is present:

```json
"cds": {
  "requires": {
    "[development]": {
      "auth": {
        "kind": "mocked",
        "users": {
          "alice": { "roles": ["support"] },
          "bob":   { "roles": ["support"] },
          "carol": { "roles": ["admin"]   }
        }
      }
    }
  }
}
```

| User | Role | Can access |
|---|---|---|
| `alice` | `support` | `ProcessorService` |
| `bob` | `support` | `ProcessorService` |
| `carol` | `admin` | `AdminService` |

> These are mock users for local development only. No passwords are required — leave the password field empty when prompted.

#### 2. Add the test script

Add the `"test"` script to the `scripts` section of **package.json**:

```json
{
  "scripts": {
    "test": "npx jest --silent test/test.js"
  }
}
```

> The `--silent` flag suppresses CDS server logs so only the Jest summary is shown. Remove it if you need to debug a failing test.

#### 3. Run the tests

Run the following command in the terminal:

```bash
npm run test
```

`--silent` suppresses CDS server logs. The output shows only the summary:

```bash
Test Suites: 1 passed, 1 total
Tests:       20 passed, 20 total
Snapshots:   0 total
Time:        ~3 s
Ran all test suites.
```

To see each individual test name, run without `--silent`:

```bash
npx jest test/test.js --verbose
```

The detailed output looks like this:

```bash
PASS  test/test.js
Test The GET Endpoints
  ✓ Should check Processor Service (2 ms)
  ✓ Should check Customers (1 ms)
  ✓ Test Expand Entity Endpoint (26 ms)
Draft Choreography APIs
  ✓ Create an incident  (19 ms)
  ✓ + Activate the draft & check Urgency code as H using custom logic (8 ms)
  ✓ + Test the incident status (2 ms)
  Close Incident and Open it again to check Custom logic
    ✓ Should Close the Incident (6 ms)
    ✓ Should patch the Incident status to Closed (4 ms)
    ✓ + Activate the draft & check Status code as C using custom logic (5 ms)
    ✓ + Test the incident status to be closed (2 ms)
    should fail to re-open closed incident
      ✓ Should Open Closed Incident (5 ms)
      ✓ Should re-open the Incident but fail (3 ms)
      ✓ Should fail to activate draft trying to re-open the incident (10 ms)
  ✓ - Delete the Draft (2 ms)
  ✓ - Delete the Incident (2 ms)
Auto-Urgency logic (processor-service.js custom handler)
  ✓ does NOT change urgency_code when title has no "urgent" (8 ms)
  ✓ sets urgency_code=H for all-caps URGENT (case-insensitive /urgent/i) (8 ms)
  ✓ sets urgency_code=H when "urgent" appears mid-title (10 ms)
Authorization
  ✓ rejects support-role user (alice) from AdminService with 403 (2 ms)
  ✓ allows carol (admin role) to read and write Customers (6 ms)

Test Suites: 1 passed, 1 total
Tests:       20 passed, 20 total
Snapshots:   0 total
Time:        ~3 s
Ran all test suites.
```

> For a more detailed guide, see [Testing](https://cap.cloud.sap/docs/node.js/cds-test) in the CAP Node.js SDK documentation.

</details>

<details>
<details>
<summary>Java: configure test users</summary>

The Authorization tests require mocked users with specific roles. Open **srv/src/main/resources/application.yaml** and add the `mock.users` block under `cds.security`:

```yaml
cds:
  security:
    mock.users:
      alice:
        roles: [ support ]
      bob:
        roles: [ support ]
      carol:
        roles: [ admin ]
```

| User | Role | Can access |
|---|---|---|
| `alice` | `support` | `ProcessorService` |
| `bob` | `support` | `ProcessorService` |
| `carol` | `admin` | `AdminService` |

> CDS security resolves roles from this config by username — not from Spring's `@WithMockUser` authorities — so users must be declared here for role-based tests to pass.

</details>

<summary>Java: test and verify</summary>

To test the application, run the following command in the terminal:

```bash
mvn verify
```

When all the test cases pass, the output looks like this:

```bash
[INFO] Tests run: 20, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 15.28 s -- in customer.incident_management.IncidentsODataTests
[INFO] 
[INFO] Results:
[INFO] 
[INFO] Tests run: 20, Failures: 0, Errors: 0, Skipped: 0
[INFO] 
[INFO] ------------------------------------------------------------------------
```

For a more detailed guide, see [Testing Applications](https://cap.cloud.sap/docs/java/developing-applications/testing#testing-cap-java-applications) in the CAP Java SDK documentation.

</details>
