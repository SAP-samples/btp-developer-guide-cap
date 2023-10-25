# Setup SAP BTP Account using Terraform

The [Terraform provider](https://registry.terraform.io/providers/SAP/btp/latest) for SAP Business Technology Platform (BTP) enables you to automate the provisioning, management, and configuration of resources on SAP Business Technology Platform. By leveraging this provider, you can simplify and streamline the deployment and maintenance of BTP services and applications. Currently the BTP Terraform provider is available in beta for non productive usage. 

The Terraform script  documented here automates the setup of an SAP BTP subaccount based on a predefined template. The scripts can be used create BTP Sub Account with Cloud Foundry or Kyma runtime. The terraform scripts does the below configuration after creating a BTP Subaccount

1. Configure the [BTP entitlements](https://github.com/SAP-samples/btp-terraform-samples/blob/main/released/discovery_center/mission_4327/setup_subaccount_cf/README.md#entitlements) required to complete the Discovery Center mission
2. Enables BTP runtime(Cloud Foundry or Kyma)
3. Create the neccessary Subscription to Software as Service(SaaS) Apps (SAP Business Application Studio(BAS), SAP Build Work Zone, standard edition etc)
4. Assign users the neccessary roles required to access the SaaS Apps e.g SAP Business Application Studio
5. Add additional users to the subaccount.

## Prerequisites

Before using this script, make sure you have Terraform downloaded and installed.

- **Install Terraform**: If you haven't already, download and install Terraform from [here](https://www.terraform.io/downloads.html).


## BTP Sub Account Setup

Based on your choice of SAP BTP Runtime for deploying the application, choose from the below options to create your Subaccount

- [BTP Subaccount with Cloud Foundry runtime environment](https://github.com/SAP-samples/btp-terraform-samples/blob/main/released/discovery_center/mission_4327/setup_subaccount_cf/README.md)
- [BTP Subaccount with Kyma runtime evironment](https://github.com/SAP-samples/btp-terraform-samples/blob/main/released/discovery_center/mission_4327/setup_subaccount_kyma/README.md)
