# Implement Multitenancy in a Full-Stack CAP Application Following SAP BTP Developer’s Guide

1. [Introduction](./cap-mtx/introduction.md)
2. [Prerequisites](./cap-mtx/mission-prerequisits/1-prerequisites.md)
3. **Enable Multitenancy**
   1. [Enable Multitenancy for the CAP Application](./cap-mtx/enable-mtx/1-enable-mtx.md)
   2. [Test the CAP Application Locally](./cap-mtx/enable-mtx/2-test-mtx.md)
   3. [Subscribe Tenants to the Application Locally](./cap-mtx/enable-mtx/3-subscribe-mtx.md)
   4. [Test with Different Users/Tenants](./cap-mtx/enable-mtx/4-test-tenants-mtx.md)
4. **Consume HTML5 Applications from SAP Build Work Zone**:
    - **Central Entry Point (CEP)**:
        1. [Prerequisites](./cep/1-cep-prerequisites.md)
        2. [Add Dependent Services and Prepare for Production](./cep/2-add-dependent-services.md)
        3. Deploy the Application in the Respective Runtime:
            - *SAP BTP, Cloud Foundry Runtime*:
                1. [Prepare for Deployment in the SAP BTP, Cloud Foundry Runtime](./cep/3-prepare-for-cf.md)
                2. [Deploy in the SAP BTP, Cloud Foundry Runtime](./cep/4-deploy-to-cf.md)
            - *SAP BTP, Kyma Runtime*:
                1. [Prepare for Deployment in the SAP BTP, Kyma Runtime](./cep/5-prepare-for-kyma.md)
                2. [Deploy in the SAP BTP, Kyma Runtime](./cep/6-deploy-to-kyma.md) 
        4. [Subscribe to the Application](./cep/7-subscribe.md)
    - **Local Entry Point (LEP):**
        1. [Prerequisites](./lep/1-prerequisites.md)
        2. [Add Dependent Services and Prepare for Production](./lep/2-add-dependent-services.md)
        3. Deploy the Application to SAP BTP, Cloud Foundry Runtime:
            1. [Prepare for Deployment in the SAP BTP, Cloud Foundry Runtime](./lep/3-prepare-for-cf.md)
            2. [Deploy in the SAP BTP, Cloud Foundry Runtime](./lep/4-deploy-to-cf.md)
        4. [Subscribe to the Application](./lep/5-subscribe.md)
