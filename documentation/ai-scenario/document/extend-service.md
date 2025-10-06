# Extend the Incident Management Application

## Prerequisites

Add dependencies required for SAP Cloud SDK for AI, and setting up the data for productive usage by following [Add Dependencies for SAP Cloud SDK for AI](./prerequisites.md)

## Extend the Incident Management Application

1. Under `srv`, create a new file called `incidents.csv`, copy the contents from [incidents.csv](https://raw.githubusercontent.com/SAP-samples/btp-end-to-end-scenario-use-cases/refs/heads/main/build-code-with-ai-capability/csv/incidents.csv).

2. Under `srv`, create a new file called `feed-data.js` and paste the following content.

```js
const fs = require("fs");
const csv = require("csv-parser");
const resourceGroup = 'default';
const embeddingModelName = 'text-embedding-ada-002';

 

async function loadCSV(filePath) {
  return new Promise((resolve, reject) => {
    const results = [];
    fs.createReadStream(filePath)
      .pipe(csv())
      .on("data", data => results.push(data))
      .on("end", () => resolve(results))
      .on("error", err => reject(err));
  });
}
 
async function feedData() {
  try {
    const { AzureOpenAiEmbeddingClient } = await import('@sap-ai-sdk/langchain');
    const db = await cds.connect.to("db");
    const { vectorEmbeddings } = db.entities;
    const incidents = await loadCSV(__dirname + "/incidents.csv");
    const embeddingClient = new AzureOpenAiEmbeddingClient({
      modelName: embeddingModelName,
      resourceGroup: resourceGroup
    },{
      destinationName: 'generative_ai_hub'
    });
 
    for (const incident of incidents) {
      const { ID, Title, Description, Resolution } = incident;
      const text = `${Title}. ${Description}. ${Resolution}`.trim();
      if (!text) continue;
 
      const embeddingResult = await embeddingClient.embedDocuments(text);
      const embedding = embeddingResult[0];
      if (!Array.isArray(embedding)) continue;
      await new Promise(res => setTimeout(res, 500));
      
     await INSERT.into(vectorEmbeddings).entries({
        metadata: ID,
        text_chunk: text,
        embedding: JSON.stringify(embedding),
        solution: Resolution
      });
      
      console.log(`Incident ${ID} stored.`);
    }
 
    return "Feeding Data completed successfully.";
  } catch (e) {
    console.error("Feeding error:", e);
    return `Error: ${e.message}`;
  }
}
 
module.exports = { feedData };
```
> [!Tip]
> This file feeds data

3. Open the `srv/service.cds` file and replace the service ProcessorService with following code snippet:

```js
service ProcessorService {
    @odata.draft.enabled
    entity Incidents as projection on my.Incidents;
        entity Solutions as projection on my.Incidents.solutions actions {
            action details() returns String;
            action acceptSolution(input1: Boolean @title : 'Did the recommended solution work for you? ?') returns String;
    };
    entity vectorEmbeddings as projection on my.vectorEmbeddings  excluding {
        embedding
    };
 
    @readonly
    entity Customers as projection on my.Customers;
    action FeedData() returns String;
}
```

> [!Tip]
> to be updated

4. Under `srv`, create a new file called `service.js` and add the following content:

```js
const cds = require('@sap/cds');
const { feedData } = require("./feed-data");
const natural = require('natural');
const tokenizer = new natural.WordTokenizer();
const {vectorEmbeddings} = cds.entities;
const resourceGroup = 'default';
const embeddingModelName = 'text-embedding-ada-002';
const stopWords = new Set(["a", "an", "the", "is", "in", "on", "of", "and", "to", "with", "for", "this", "that", "it", "by", "at"]);
 
class ProcessorService extends cds.ApplicationService {
  /** Registering custom event handlers */
  async init() {
    this.after("CREATE", "Incidents", (req) => this.getRagResponse(req));
    this.on("FeedData", feedData);
 
    this.on('acceptSolution', async (req) => {
      if (!req.data.input1) return req.reject(400, "Solution acceptance is required.");
      let result = await cds.run(SELECT.from("Incidents.solutions").where({ ID: req.params[1].ID }));
      if (!result.length) return req.reject(404, "No solutions found for the given incident.");
      await cds.run(UPDATE('Incidents').set({ status_code: 'R' }).where({ ID: req.params[0].ID }));
      await this.generateAndStoreEmbeddings(req.params[0].ID, result[0].solution);
      req.info("Data added successfully!");
    });

    this.on('details', async (req) => {
      let result = await cds.run(SELECT.from("Incidents.solutions").where({ ID: req.params[1].ID }));
      const aioutput = await this.getDetails(result[0].solution);
      req.info(aioutput);
    });

    return super.init();
  }
 
  async preprocessInput(issueTitle) {
    if (!issueTitle) return "";
 
    // Convert to lowercase & trim spaces
    let processedTitle = issueTitle.toLowerCase().trim();
 
    // Remove special characters (keep only letters, numbers, and spaces)
    processedTitle = processedTitle.replace(/[^a-zA-Z0-9 ]/g, '');
 
    // Tokenize the sentence into words
    let words = tokenizer.tokenize(processedTitle);
 
    // Remove stop words
    words = words.filter(word => !stopWords.has(word));
 
    // Apply simple stemming (reduces words to base form)
    const stemmedWords = words.map(word => natural.PorterStemmer.stem(word));
 
    // Join words back into a processed string
    return stemmedWords.join(" ");
  }

  /** Generate and store embeddings */
  async generateAndStoreEmbeddings(IncidentId, solution) {
    try {
      const { AzureOpenAiEmbeddingClient } = await import('@sap-ai-sdk/langchain');
      const db = await cds.connect.to("db");
      const { Incidents } = db.entities;
      const [incident] = await db.read("Incidents").where({ ID: IncidentId }).columns("title");
      if (!incident) throw new Error("Incident not found");
 
      const conversation = await db.read("Incidents.conversation").where({ up__ID: IncidentId }).columns("message");
      const messages = conversation.map(c => c.message).join(' ').trim();
 
      const textData = `${incident.title} ${messages}`.trim();
      if (!textData) throw new Error("No valid text data found for embedding.");
      let textSplits = ["this is test data"];
      const embeddingClient = new AzureOpenAiEmbeddingClient({
        modelName: embeddingModelName,
        resourceGroup: resourceGroup
      },{
        destinationName: 'generative_ai_hub'
      });
  
      const embeddingResult = await embeddingClient.embedDocuments(textData);
      const embedding = embeddingResult[0];
      if (!Array.isArray(embedding)) throw new Error("Invalid embedding generated");

      await INSERT.into("vectorEmbeddings").entries({
        metadata: `Incident ID: ${IncidentId}`,
        text_chunk: textData,
        embedding: JSON.stringify(embedding),
        solution
      });
 
      console.log("Embedding stored successfully!");
    } catch (error) {
      console.error("Error storing embedding:", error);
    }
  }
 
  /** RAG-based Response Retrieval */
  async getRagResponse(req) {
    try {
      const { AzureOpenAiEmbeddingClient } = await import('@sap-ai-sdk/langchain');
      const db = await cds.connect.to("db");
      const [incident] = await db.read("Incidents").where({ ID: req.ID }).columns("title");
      if (!incident) throw new Error("Incident not found");
 
      const conversation = await db.read("Incidents.conversation").where({ up__ID: req.ID }).columns("message");
      const messages = conversation.map(c => c.message).join(' ').trim();
      let userQuery = `${incident.title} ${messages}`.trim();
      userQuery = await this.preprocessInput(userQuery);
   
      const embeddingClient = new AzureOpenAiEmbeddingClient({
        modelName: embeddingModelName,
        maxRetries: 0,
        resourceGroup: resourceGroup
      },{
        destinationName: 'generative_ai_hub'
      });
  
      let embedding = await embeddingClient.embedQuery(userQuery);
    
      const embedding_str = `'[${embedding.toString()}]'`
      const selectStmt = `SELECT TOP 3 *,TO_NVARCHAR(solution) as PAGE_CONTENT,COSINE_SIMILARITY(embedding, TO_REAL_VECTOR(${embedding_str})) as SCORE FROM ${vectorEmbeddings} ORDER BY SCORE DESC`;
      const ragResponse = await db.run(selectStmt);
 
      let solutionsMap = new Map();
      ragResponse.forEach((item) => {
        if (item.PAGE_CONTENT) {
          solutionsMap.set(item.PAGE_CONTENT, Math.max(solutionsMap.get(item.PAGE_CONTENT) || 0, item.SCORE));
        }
      });
 
      let solutions = Array.from(solutionsMap, ([content, score]) => ({ content, score }))
        .filter((item) => item.score > 0.70)
        .sort((a, b) => b.score - a.score);
 
      const solutionEntries = solutions.map((s) => ({
        up__ID: req.ID,
        solution: s.content,
        confidence: `${(s.score * 100).toFixed(2)}%`
      }));
      
      await INSERT.into("Incidents.solutions").entries(solutionEntries);
      return solutionEntries;
    } catch (error) {
      console.error("Error retrieving RAG response:", error);
      throw error;
    }
  }
    async getDetails(userQuery){
    try{ 
        const { OrchestrationClient } = await import ('@sap-ai-sdk/orchestration');
        const orchestrationClient = new OrchestrationClient({
        llm: {
            model_name: 'gpt-4o'
        },
        templating: {
            template: [
            {
                role: 'user',
                content: `In about 100 words, describe the following recommended solution: '${userQuery}'. Start by briefly stating the problem this solution addresses. Then, present the solution in a step-by-step format using numbered bullet points (1., 2., 3., etc.). Each step should be clear and action-oriented. End with any important considerations the user should keep in mind. Keep the description professional, concise, and easy to follow.`
            }
            ]
        }
        }, resourceGroup,
        {
        destinationName: 'generative_ai_hub'
        });
        const response = await orchestrationClient.chatCompletion();
        return response.getContent();
    } catch (error) {
      throw new Error("No response received from orchestration client.");
    }
  
  }
 
}
 
module.exports = { ProcessorService };
 
```

> [!Tip]
> to be updated

5. In the root project, create a new file called `request.http` and paste the following content:

```http
### Trigger the Feed Data action
POST http://localhost:4004/odata/v4/processor/FeedData
Content-Type: application/json
 
{}
```

## Add Annotations to Enhance the SAP Fiori UI

1. Open the `app/incident-management/annotation.cds` file and paste the following code:

```js
using ProcessorService as service from '../../srv/service';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Customer}',
                Value : customer_ID,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'i18nOverview',
            Facets : [
                {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : '{i18n>GeneralInformation}',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Details}',
                    ID : 'i18nDetails',
                    Target : '@UI.FieldGroup#i18nDetails',
                },],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Conversation}',
            ID : 'i18nConversations',
            Target : 'conversation/@UI.LineItem#i18nConversations',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>RecommendedSolutions}',
            ID : 'i18nRecommendedSolutions',
            Target : 'solutions/@UI.LineItem#i18nRecommendedSolutions',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.name,
            Label : '{i18n>Customer}',
        },
        {
            $Type : 'UI.DataField',
            Value : status.descr,
            Label : '{i18n>Status}',
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.descr,
            Label : '{i18n>Urgency}',
        },
          
         
    ],
);

annotate service.Incidents with {
    customer @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Customers',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : customer_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'firstName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'lastName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'phone',
            },
        ],
    }
};

annotate service.Incidents with @(
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ]
);
annotate service.Incidents with {
    status @Common.Label : '{i18n>Status}'
};
annotate service.Incidents with {
    urgency @Common.Label : '{i18n>Urgency}'
};
annotate service.Incidents with {
    urgency @Common.ValueListWithFixedValues : true
};
annotate service.Urgency with {
    code @Common.Text : descr
};
annotate service.Incidents with {
    status @Common.ValueListWithFixedValues : true
};
annotate service.Status with {
    code @Common.Text : descr
};
annotate service.Incidents with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : customer.name,
        },
        TypeImageUrl : 'sap-icon://alert',
    },
    
);
annotate service.Incidents with @(
    UI.FieldGroup #i18nDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },{
                $Type : 'UI.DataField',
                Value : urgency_code,
            },],
    }
);
annotate service.Incidents with {
    customer @Common.Text : {
            $value : customer.name,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Incidents with {
    customer @Common.ValueListWithFixedValues : false
};


annotate service.Incidents with {
    urgency @Common.Text : urgency.descr
};
annotate service.Incidents.conversation with @(
    UI.LineItem #i18nConversations : [
        {
            $Type : 'UI.DataField',
            Value : author,
            Label : '{i18n>Author}',
        },{
            $Type : 'UI.DataField',
            Value : message,
            Label : '{i18n>Message}',
        },{
            $Type : 'UI.DataField',
            Value : timestamp,
            Label : '{i18n>Date}',
        },]
);
annotate service.Incidents with @Common.SemanticKey: [ID]{
    ID @Core.Computed
};

annotate service.Solutions with @(
    UI.LineItem #i18nRecommendedSolutions : [
        {
            $Type : 'UI.DataField',
            Value : confidence,
            Label : '{i18n>ConfidenceScore}',
        },
        {
            $Type : 'UI.DataField',
            Value : solution,
            Label : '{i18n>Solution}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'ProcessorService.details',
            Label : 'Detailed Solution',
            Inline : true,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'ProcessorService.acceptSolution',
            Label : 'Accept Solution',
            Inline : true,
        },
    ]
);
 
```


## Next Step

[Test the Scenario End to End](./e2e-testing.md)
