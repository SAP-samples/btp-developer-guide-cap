# Set Up SAP BTP Account Using Terraform provider for SAP BTP

The Terraform provider for SAP Business Technology Platform (BTP) enables you to automate the provisioning, management, and configuration of resources on SAP BTP. By leveraging this provider, you can simplify and streamline the deployment and maintenance of SAP BTP services and applications.

Currently, the terraform provider for SAP BTP is available in beta for non productive usage: [Terraform provider for SAP BTP](https://registry.terraform.io/providers/SAP/btp/latest).

The Terraform script documented here automates the setup of an SAP BTP subaccount based on a predefined template. The scripts can be used create SAP BTP subaccount with Cloud Foundry or Kyma runtime. The Terraform script does the below configuration after creating a SAP BTP subaccount:

1. Configures the SAP BTP entitlements required to complete the mission. See [Setup SAP BTP Account using Terraform](https://github.com/SAP-samples/btp-terraform-samples/blob/main/released/discovery_center/mission_4327/README.md).
2. Enables the SAP BTP runtime (Cloud Foundry or Kyma).
3. Creates the neccessary subscription to applications: SAP Business Application Studio (BAS), SAP Build Work Zone, standard edition, etc.
4. Assigns users the neccessary roles required to access the applications, such as SAP Business Application Studio.
5. Adds additional users to the subaccount.

# Prerequisites

Before using this script, make sure you have Terraform downloaded and installed.

- **Install Terraform**: If you haven't already, download and install Terraform: [Install Terraform](https://www.terraform.io/downloads.html).


# SAP BTP Subaccount Setup

To create your subaccount, either choose one of the options based on your runtime of choice for deploying the application in SAP BTP, or use the Terraform script provided in the **Quick Account Setup** card in the **DEVELOP BASIC APPLICATION** phase of the mission: 

- [Subaccount in SAP BTP with SAP BTP, Cloud Foundry Runtime Enabled](https://github.com/SAP-samples/btp-terraform-samples/blob/main/released/discovery_center/mission_4327/)
- [Configure the SAP BTP, Kyma Runtime in Your Subaccount](https://github.com/SAP-samples/btp-terraform-samples/tree/main/released/discovery_center/mission_4327/step2_kyma)
