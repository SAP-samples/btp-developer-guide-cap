# View Change History

To test the functionality and flow of our change tracking feature, we will go through a simple scenario. In this section, we will make changes to a sample dataset, track those changes using the feature, and then explore the change history to observe how it captures and records modifications. 
Let's get started!


1. Open the Incident Management application from SAP Build Workzone.

![Incidents app in Lauchpad](images/app-in-launchpad.png)

2. It displays a list of incidents. Open an incident and modify its details.

![List of Incidents](images/list-of-incidents.png)

3. Upon opening an incident, you can see an additional tab called **Change History**. This tab displays details about modifications made to the fields marked for change tracking during the **implementation** phase. To add a new conversation, choose **Edit**.

![Incident Overview](images/incident-overview.png)

4. Create a new conversation and choose **Save**.

![Add Conversation](images/add-conversation.png)

5. Since the **message** field of the **conversation** entity has been marked for change tracking, it should be visible in **Change History**. 

![Change History for Conversation](images/change-history-conversation.png)

Both the old and updated values of the message field are shown, along with the type of the change, user ID and the timestamp of the modification.

6. In **Change History**, you have the option to modify the incident's title, status, or customer, and view the changes.

![Change the Incident](images/change-incident-details.png)

![Change History for Incident](images/change-history-overview.png)

# Summary

Congratulations, you have successfully implemented and tested the change tracking feature in your application.
