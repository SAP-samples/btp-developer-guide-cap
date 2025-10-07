# Extend the Incident Management Application with document AI

## Prerequisites

Make sure you've followed the steps at [Add Dependencies for Attachments and SAP Document AI ](./prerequisites-2.md).

## Extend the Incident Management Application with a New Service

1. Under `srv`, create a new file called `ticket-admin.cds` and paste the following content:

```js
using { sap.capire.incidents as my } from '../db/schema';

extend my.Incidents with {
  description: String @UI.MultiLineText;
}

service TicketService {
  @odata.draft.enabled
  entity Incidents as projection on my.Incidents;

}
```
> [!Tip]
> This file defines a new custom service called `TicketService`, which extends the existing `Incidents` entity.

2. Under `srv`, create handler for the `TicketService` with file called `ticket-admin.js` and paste the following content:

```js
const cds = require('@sap/cds');
const FormData = require('form-data');
const { getRagResponse } = require("./generate-solutions");
const { executeHttpRequest } = require('@sap-cloud-sdk/http-client');
const {Incidents} = cds.entities;
class TicketService extends cds.ApplicationService {
  init() {
    const { Incidents } = this.entities;
    this.before('CREATE', Incidents, async (req) => { 
      // Fill the temporary data for the incident
      req.data.title = "Processing Invoice Upload ..."
    });
    this.after('CREATE', Incidents, async (data) =>  await this.emit('enrichIncident', data));

    this.on('enrichIncident', async (data) => {
      console.log(`Received enrichIncident with data:`, data);
      const AttachmentsSrv = await cds.connect.to('attachments');
      const firstAttachment = data.data.attachments[0];
      const keys = { ID: firstAttachment.ID };
      const target = this.entities["Incidents.attachments"];
      const content = await AttachmentsSrv.get(target, keys);
      if(!content) throw new Error(`No content found for attachment ID ${firstAttachment.ID}`);
      const customerData = await this.extractCustomerDetails(data, content);
      if (customerData) {
        await this.createIncidentfromdata(data.data, customerData);
      } else {
        console.warn(`No customer data found on request`);
      }   
     

    });
    return super.init();
  }

    async extractCustomerDetails (req, content) {
    const stream = content;
    const fileName = req.data.attachments?.[0]?.fileName || "invoice.png";
    const buffer = await new Promise((resolve, reject) => {
      const chunks = [];
      stream.on('data', chunk => chunks.push(chunk));
      stream.on('end', () => resolve(Buffer.concat(chunks)));
      stream.on('error', reject);
    });
         const form = new FormData();
         form.append('file', buffer, { filename: fileName , contentType: 'image/png' });
        
        form.append('options', JSON.stringify({
        clientId: 'default',
        documentType: 'invoice',
        schemaId: '<Schema ID>',
        schemaVersion: "<Schema Version>"
        }));
        let documentId;
          // working code
        try {
          const response = await executeHttpRequest(
            { destinationName: 'doc-info-extraction' },
            {
              method: 'POST',
              url: '/document-information-extraction/v1/document/jobs',
              headers: {
                ...form.getHeaders()
              },
              data: form
            }
          );
          documentId = response.data.id;
        } catch (error) {
          if (error.message?.includes('timeout')) {
            console.error('Request timed out');
          } else {
            console.error('Upload error:', error.response?.data || error.message);
          }
        }
        const docdata = await this.getdocData(documentId);
        console.log("Document data:", docdata);
        if (!docdata || !docdata.extraction || !docdata.extraction.headerFields) {
          console.error('No extraction data found in document data');
          return { customerId: null, customerName: null };
        }
        console.log("Header fields:", docdata.extraction.headerFields);
        if (!docdata.extraction.headerFields || docdata.extraction.headerFields.length === 0) {
          console.error('No header fields found in document data');
          return { customerId: null, customerName: null };
        }
        console.log("Header fields:", docdata.extraction.headerFields);
        // Assuming the headerFields contain customerId and customerName
        const headerFields = docdata.extraction.headerFields;
        let customerId, customerName;

        for (const field of headerFields) {
        const name = field.name?.toLowerCase();
        if (name === "customerid") {
            customerId = field.value;
        } else if (name === "customername") {
            customerName = field.value;
        }
        }
         return {customerId,customerName};
  }

    async getdocData(ID){
          try {
            while (true) {
         const response = await executeHttpRequest(
          { destinationName: 'doc-info-extraction' }, // match with BTP
          {
            method: 'GET',
            url: `/document-information-extraction/v1/document/jobs/${ID}`, // relative to the destination's URL
          }
        );
              const status = response.data.status;
              console.log(`Status: ${status}`);
        
              if (status === 'DONE') {
                console.log('Extraction complete');
                return response.data;
              }
        
              if (status === 'FAILED' || status === 'CANCELED') {
                console.error(`Process ended with status: ${status}`);
                return null;
              }
        
              await new Promise(resolve => setTimeout(resolve, 5000));
            }
          } catch (error) {
            if (error.message?.includes('timeout')) {
              console.error('Request timed out');
            } else {
              console.error('Fetch error:', error.response?.data || error.message);
            }
            return null;
          }
    }

    async getincidentdata(description){
  console.log(description);
  const resourceGroup = 'default'
  try{ 
    const { OrchestrationClient } = await import ('@sap-ai-sdk/orchestration');
    const orchestrationClient = new OrchestrationClient({
    llm: {
        model_name: 'gpt-4o'
    },
      templating: {
        template: [
                {
                  role: 'system',
                  content: `You are an assistant that analyzes issue descriptions and generates:
                  - A clear and concise title
                  - A brief summary message
                  - An urgency level based on the content

                  Respond only with a JSON object in this format:
                  {
                    "title": "Short title here",
                    "message": "Brief message here",
                     "urgency": "L" | "M" | "H"
                  }`
                },
                {
                  role: 'user',
                  content: `Given the following issue description, respond only with a JSON object (no markdown or explanation).
                  Issue description: {{?description}} `
                }
        ]
      }
    }, resourceGroup,
    {
    destinationName: 'generative_ai_hub'
    });
    const response = await orchestrationClient.chatCompletion({
      inputParams: { description: description }
    });
    console.log(response.getContent());
    return JSON.parse(response.getContent());
} catch (error) {
  throw new Error(error+"No response received from orchestration client.");
}

}

    async createIncidentfromdata(req, customerData){
      const description = req.description;
      const response = await this.getincidentdata(description);
      if (!response || !response.title || !response.message) {
        console.error('Invalid response from getincidentdata:', response);
        return;
      }
      console.log(customerData);
      const data = {
        title: response.title,
        customer_ID: customerData.customerId,     
        urgency_code: response.urgency,      
        status_code: 'N', 
        conversation: [
          {
            ID: cds.utils.uuid(),
            message: response.message
          }
        ]
      };
    
      try {
        const updated = await cds.run(
            UPDATE(Incidents).set(data).where({ ID: req.ID })
            );
          console.log(updated);
         await getRagResponse(req.ID);
      } catch (error) {
        console.error('Insert failed:', error);
      }
    
    }

}

module.exports = { TicketService };
```

> [!Tip]
> This handler processes new records by retrieving attachments, extracting key details through a document service, and using AI to generate a title, summary, and urgency level — seamlessly connecting file uploads, document analysis, and intelligent enrichment.

3. Replace the `schemaId` and `schemaVersion` values with the values from your SAP Document AI instance.

## Next Step

- [Add SAP Fiori UI Application with Attachments](./extended-ui.md)
