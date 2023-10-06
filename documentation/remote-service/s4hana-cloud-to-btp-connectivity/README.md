# Configure the connectivity between SAP S/4HANA Cloud and SAP BTP

## Usage scenario / Introduction 

To conect to an SAP S/4HANA Cloud system using service binding you have to register the system at your SAP BTP account.

## Prerequisites
You need an user with administrator access for the SAP BTP global account and the SAP S/4HANA Cloud system.

## Content

> You can skip this exercise when you want to test this scenario with a mock server only.

### SAP Business Technology Platform

1. In your SAP Business Technology Platform Cockpit, open your global account and choose
*System Landscape*.

2. In the Systems Landscape, choose *Add System*.


   ![Register System](./images/setup1.png)


3. In the *Register System* dialog box, enter a name for the SAP S/4HANA Cloud system you want to connect.

- Recommendation: use a name that uniquely identifies this system, for example, system ID.
- Example: **S/4HANA Cloud DEV System**

4. In the Type dropdown list, choose *SAP S/4HANA Cloud*.

5. Choose *Add*.

   ![Choose Add](./images/add-system02.png)

6. Configure the communication flow. Select **All Communication Scenarios**

7. Set the The SAP Business Technology Platform generates an integration token so the SAP S/4HANA Cloud system administrator can configure integration with the SAP Cloud Platform from your SAP S/4HANA Cloud system. Choose **Get Token** 

   ![Get Token](./images/add-system03.png)

8. Copy the generated token and close the dialog box.

  

### SAP S/4HANA Cloud

1. Log onto your SAP S/4HANA Cloud tenant.

2. Navigate to *Home -> Communication Management* tab and choose the tile *Maintain Extensions on SAP BTP*.

   ![Maintain](./images/setup4.png)

3. On the *Maintain Extensions on SAP BTP* screen in the Integration section, choose *New*.

   ![New](./images/setup5.png)

4. In the Integration Token field, paste in the integration token generated and copied from the SAP Business Technology Platform.

      ![Paste](./images/setup6.png)

5. Enter a description for your system integration token.

- Recommendation: use the same name you entered in SAP Business Technology Platform when you generated the token.
- Example: >S/4HANA Cloud system name<

6. Choose *Save*.

- A new entry is displayed for your system in the table with the status *Enabling*.
- Wait for a few seconds.
- After the automated integration, the status of your system integration changes to *Enabled*.
- The same takes place on the SAP Business Technology Platform side. You will see the system as *Registered* – potentially after a quick refresh.

   ![Registerd](./images/setup3.3.png)


See also: [Register an SAP S/4HANA Cloud System in a Global Account in SAP BTP](https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/28171b629f3549af8c1d66d7c8de5e18.html).