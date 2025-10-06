## Test the Incident Management Application

## Prerequisite

[Intergrate with SAP Build Work Zone](./integrate-workzone.md)

## Testing the Scenario End to End

1. Once you open the application, click the URL under **Web Applications**.

    ![webapp](../images/teste2e/open-webapp.png)

2. Choose **Go**, which loads all the incidents.

    ![testing](../images/teste2e/go.png)

3. Choose **Create**.

    ![testing](../images/teste2e/create.png)

4. Fill in the incident details:

    1. In the **Title** field, enter **Printer is not working**.
    
    2. In the **Customer** dropdown menu, select a customer of your choice.

        ![testing](../images/teste2e/valuehelp.png)

    3. Leave the **Status** and **Urgency** fields with their default value.

    4. In the **Conversation** section, choose **Create**.

    5. Enter the **Paper is not printing** message.

    6. Choose **Create**.

        ![testing](../images/teste2e/createinobject.png)

5. In the **Recommended Solutions** section, you will be able to see the solutions with the confidence score.

    ![testing](../images/teste2e/recommend.png)

6. Choose **Accept Solution**.

    ![testing](../images/teste2e/accept1.png)

7. In the dropdown menu, select **Yes**, if the recommended solution worked. Choose **Accept Solution** again.

    ![testing](../images/teste2e/accept2.png)

8. You will get a notification: **Data added successfully!**

    ![testing](../images/teste2e/data-saved.png)
