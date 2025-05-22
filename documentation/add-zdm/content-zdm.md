# Zero Downtime Maintenance for Application Contents
In this section, we refer to the User Interface (UI) and BTP services as "content." Deploying the UI differs from deploying the backend because UI files are not version-controlled, and the blue-green deployment strategy does not support having multiple UIs designated as live or idle. Instead, content is uploaded immediately, without waiting for live or idle applications, ensuring that users receive the latest codebase instantly. Consequently, it's essential to ensure that the pushed content is small and non-breaking, so the frontend remains stable even when the backend is in the testing phase.

## Sequence of small changes
Instead of one big change that modifies setup, code, and data in the same step, run a sequence of small changes that changes things bit by bit.
If there are changes in the UI, the backend should be first updated, then the UI. This is necessary as if the UI needs to consume a new Entity which is not yet available in the backend, it will cause regressions. 
Here's an example of how this can be done.

<img src="./images/zdmUI.png"/>


>
>For example, imagine you want to deploy a new front-end feature that relies on a specific API endpoint.
>
>If you deploy both the front-end update and the new API endpoint together in one pipeline, there will be a moment when the front-end attempts to call the API before it’s fully deployed, leading to potential errors.
>
>To avoid this disruption, you can split the deployment into two steps:
>
>First, run a pipeline that deploys the API endpoint.
>Then, run a second pipeline to update the front-end to use the new API.
>

### Read More:
- **[Code Changes](./code-zdm.md)**
- **[Persistance Changes](./persistance-zdm.md)**
- **[Content Changes](content-zdm.md)**