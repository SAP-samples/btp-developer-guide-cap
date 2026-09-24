const cds = global.cds || require('@sap/cds')

module.exports = async srv => {

  srv.before('CREATE', "ObjectIdentifierMappingCollection", req => {
    req.data.ObjectID = randomString(10)
  });

  srv.after("CREATE", "ObjectIdentifierMappingCollection", data => {
    const { CorporateAccountCollection } = srv.entities;
    srv.run(UPDATE(CorporateAccountCollection)
      .with({
        ExternalID: data.RemoteObjectID,
        ExternalSystem: data.RemoteBusinessSystemID
      })
      .where({ AccountID: data.LocalObjectID }));
  })

  srv.before('CREATE', "CorporateAccountCollection", (req) => {
    req.data.ObjectID = randomString(10)
    req.data.AccountID = randomString(5)
    req.data.BusinessPartnerFormattedName = req.data.Name
    console.info("Created AccountID:: ", req.data.AccountID)
  });

  srv.after('CREATE', "CorporateAccountCollection", async (data) => {

    console.info("After create Account:: ", data)
    const { AccountID, CountryCode, Street, City, StreetPostalCode } = data;
    const ObjectID = randomString(5)
    const { CorporateAccountAddressCollection } = srv.entities;
    await cds.run(INSERT.into(CorporateAccountAddressCollection).entries({ ObjectID, AccountID, CountryCode, Street, City, StreetPostalCode }))
  });

  srv.before('CREATE', "CorporateAccountTeamCollection", (req) => {
    req.data.ObjectID = randomString(10)
  });

  const randomString = (myLength) => {
    const chars =
      "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
    const randomArray = Array.from(
      { length: myLength },
      () => chars[Math.floor(Math.random() * chars.length)]
    );

    const randomString = randomArray.join("");
    return randomString;
  };

}