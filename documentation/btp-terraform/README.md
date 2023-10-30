# Set Up SAP BTP Account Using Terraform

The Terraform provider for SAP Business Technology Platform (BTP) enables you to automate the provisioning, management, and configuration of resources on SAP BTP. By leveraging this provider, you can simplify and streamline the deployment and maintenance of SAP BTP services and applications.

Currently, the SAP BTP provider is available in beta for non productive usage: [SAP BTP Terraform](https://registry.terraform.io/providers/SAP/btp/latest).

The Terraform script documented here automates the setup of an SAP BTP subaccount based on a predefined template. The scripts can be used create SAP BTP subaccount with Cloud Foundry or Kyma runtime. The Terraform script does the below configuration after creating a SAP BTP subaccount:

1. Configures the SAP BTP entitlements required to complete the mission. See [Setup SAP BTP Account using Terraform](https://github.com/SAP-samples/btp-terraform-samples/blob/main/released/discovery_center/mission_4327/setup_subaccount_cf/README.md#entitlements).
2. Enables the SAP BTP runtime (Cloud Foundry or Kyma).
3. Creates the neccessary subscription to applications: SAP Business Application Studio (BAS), SAP Build Work Zone, standard edition, etc.
4. Assigns users the neccessary roles required to access the applications, such as SAP Business Application Studio.
5. Adds additional users to the subaccount.

## Prerequisites

Before using this script, make sure you have Terraform downloaded and installed.

- **Install Terraform**: If you haven't already, download and install Terraform: [Install Terraform](https://www.terraform.io/downloads.html).


## SAP BTP Subaccount Setup

To create your subaccount, choose one of the options based on your choice of SAP BTP Runtime for deploying the application: 

- [SAP BTP Subaccount with Cloud Foundry Runtime](https://github.com/SAP-samples/btp-terraform-samples/blob/main/released/discovery_center/mission_4327/setup_subaccount_cf/README.md)
- [SAP BTP Subaccount with Kyma Runtime](https://github.com/SAP-samples/btp-terraform-samples/blob/main/released/discovery_center/mission_4327/setup_subaccount_kyma/README.md)
