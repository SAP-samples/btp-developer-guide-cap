const cds = global.cds || require('@sap/cds')
module.exports = async srv => {
    let IDRange = 170000, addressIdRange = 1000
    const messaging = await cds.connect.to('messaging')
    // Mock events for s4
    srv.after("CREATE", "A_BusinessPartner", data => {
        const payload = {"BusinessPartner": data.BusinessPartner}
        messaging.emit("sap.s4.beh.businesspartner.v1.BusinessPartner.Created.v1", payload);
        console.log('<< event emitted', payload);
    });

    srv.after("UPDATE", "A_BusinessPartner", data => {
        const payload = {"BusinessPartner": data.BusinessPartner}
        messaging.emit("sap.s4.beh.businesspartner.v1.BusinessPartner.Changed.v1", payload);
        console.log('<< event emitted', payload);
    });

    srv.before("CREATE", "A_BusinessPartner", (req, data) => {
        const {BusinessPartner} = req.data
        if(!BusinessPartner){
            IDRange++
            req.data.BusinessPartner = IDRange.toString()
        }
        const {to_BusinessPartnerAddress} = req.data

        if(to_BusinessPartnerAddress){
            to_BusinessPartnerAddress.forEach(element => {
                if(element.AddressID){
                    return 
                }
                else{
                    addressIdRange++
                    element.AddressID = addressIdRange
                }
            });
        }
    })

    srv.before("CREATE", "A_BusinessPartnerAddress", (req, data) => {
        const {AddressID} = req.data
        if(!AddressID){
            addressIdRange++
            req.data.AddressID = addressIdRange.toString()
        }
    })

    
}