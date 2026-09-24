/* checksum : 421386e76599d8306dcdab68b0d2b94e */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service API_BUSINESS_PARTNER {};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Email Address'
entity API_BUSINESS_PARTNER.A_AddressEmailAddress {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Number'
  key AddressID : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Person Number'
  key Person : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Sequence Number'
  key OrdinalNumber : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Standard addr.'
  @sap.quickinfo : 'Flag: this address is the default address'
  IsDefaultEmailAddress : Boolean;
  @sap.label : 'E-Mail Address'
  EmailAddress : String(241);
  @sap.display.format : 'UpperCase'
  @sap.label : 'E-Mail Address'
  @sap.quickinfo : 'E-Mail Address Search Field'
  SearchEmailAddress : String(20);
  @sap.label : 'Notes'
  @sap.quickinfo : 'Communication link notes'
  AddressCommunicationRemarkText : String(50);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Fax Number'
entity API_BUSINESS_PARTNER.A_AddressFaxNumber {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Number'
  key AddressID : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Person Number'
  key Person : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Sequence Number'
  key OrdinalNumber : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Standard No.'
  @sap.quickinfo : 'Standard Sender Address in this Communication Type'
  IsDefaultFaxNumber : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Country/Region'
  @sap.quickinfo : 'Country/Region for Telephone/Fax Number'
  FaxCountry : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Fax'
  @sap.quickinfo : 'Fax number: dialling code+number'
  FaxNumber : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Extension'
  @sap.quickinfo : 'Fax no.: Extension'
  FaxNumberExtension : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Fax number'
  @sap.quickinfo : 'Complete number: dialling code+number+extension'
  InternationalFaxNumber : String(30);
  @sap.label : 'Notes'
  @sap.quickinfo : 'Communication link notes'
  AddressCommunicationRemarkText : String(50);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Home Page URL'
entity API_BUSINESS_PARTNER.A_AddressHomePageURL {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Number'
  key AddressID : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Person Number'
  key Person : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Sequence Number'
  key OrdinalNumber : String(3);
  @sap.display.format : 'Date'
  @sap.label : 'from'
  @sap.quickinfo : 'Valid-from date - in current Release only 00010101 possible'
  key ValidityStartDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Standard addr.'
  @sap.quickinfo : 'Flag: this address is the default address'
  key IsDefaultURLAddress : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'URI address'
  @sap.quickinfo : 'URI address search field'
  SearchURLAddress : String(50);
  @sap.label : 'Notes'
  @sap.quickinfo : 'Communication link notes'
  AddressCommunicationRemarkText : String(50);
  @sap.label : 'URI length'
  @sap.quickinfo : 'URI field length'
  URLFieldLength : Integer;
  @sap.label : 'URI'
  @sap.quickinfo : 'Universal Resource Identifier (URI)'
  WebsiteURL : String(2048);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Phone Number'
entity API_BUSINESS_PARTNER.A_AddressPhoneNumber {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Number'
  key AddressID : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Person Number'
  key Person : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Sequence Number'
  key OrdinalNumber : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Country/Region'
  @sap.quickinfo : 'Country/Region for Telephone/Fax Number'
  DestinationLocationCountry : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Standard No.'
  @sap.quickinfo : 'Standard Sender Address in this Communication Type'
  IsDefaultPhoneNumber : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Telephone'
  @sap.quickinfo : 'Telephone no.: dialling code+number'
  PhoneNumber : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Extension'
  @sap.quickinfo : 'Telephone no.: Extension'
  PhoneNumberExtension : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Telephone number'
  @sap.quickinfo : 'Complete Number: Dialling Code+Number+Extension'
  InternationalPhoneNumber : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Mobile phone'
  @sap.quickinfo : 'Indicator: Telephone is a Mobile Telephone'
  PhoneNumberType : String(1);
  @sap.label : 'Notes'
  @sap.quickinfo : 'Communication link notes'
  AddressCommunicationRemarkText : String(50);
};

@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Contact Person Address'
entity API_BUSINESS_PARTNER.A_BPContactToAddress {
  @sap.display.format : 'UpperCase'
  @sap.label : 'BP Relationship No.'
  @sap.quickinfo : 'BP Relationship Number'
  key RelationshipNumber : String(12);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartnerCompany : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartnerPerson : String(10);
  @sap.display.format : 'Date'
  @sap.label : 'Valid To'
  @sap.quickinfo : 'Validity Date (Valid To)'
  key ValidityEndDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Number'
  key AddressID : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Number'
  AddressNumber : String(10);
  @sap.label : 'Street 3'
  AdditionalStreetPrefixName : String(40);
  @sap.label : 'Street 5'
  AdditionalStreetSuffixName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Time zone'
  @sap.quickinfo : 'Address time zone'
  AddressTimeZone : String(6);
  @sap.label : 'c/o'
  @sap.quickinfo : 'c/o name'
  CareOfName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'City Code'
  @sap.quickinfo : 'City code for city/street file'
  CityCode : String(12);
  @sap.label : 'City'
  CityName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Postal Code'
  @sap.quickinfo : 'Company Postal Code (for Large Customers)'
  CompanyPostalCode : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Country/Region Key'
  Country : String(3);
  @sap.label : 'County'
  County : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Delivery Service No.'
  @sap.quickinfo : 'Number of Delivery Service'
  DeliveryServiceNumber : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Delvry Serv Type'
  @sap.quickinfo : 'Type of Delivery Service'
  DeliveryServiceTypeCode : String(4);
  @sap.label : 'District'
  District : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Title'
  @sap.quickinfo : 'Form-of-Address Key'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  FormOfAddress : String(4);
  @sap.label : 'Full Name'
  @sap.quickinfo : 'Full name of a party (Bus. Partner, Org. Unit, Doc. address)'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  FullName : String(80);
  @sap.label : 'Different City'
  @sap.quickinfo : 'City (different from postal city)'
  HomeCityName : String(40);
  @sap.label : 'House Number'
  HouseNumber : String(10);
  @sap.label : 'Supplement'
  @sap.quickinfo : 'House number supplement'
  HouseNumberSupplementText : String(10);
  @sap.label : 'Language Key'
  Language : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'PO Box'
  POBox : String(10);
  @sap.label : 'PO Box City'
  @sap.quickinfo : 'PO Box city'
  POBoxDeviatingCityName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'PO Box Ctry/Region'
  @sap.quickinfo : 'PO Box of Country/Region'
  POBoxDeviatingCountry : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'PO Box Region'
  @sap.quickinfo : 'Region for PO Box (Country, State, Province, ...)'
  POBoxDeviatingRegion : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'PO Box w/o No.'
  @sap.quickinfo : 'Flag: PO Box Without Number'
  POBoxIsWithoutNumber : Boolean;
  @sap.label : 'PO Box Lobby'
  POBoxLobbyName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'PO Box Postal Code'
  POBoxPostalCode : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Person Number'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  Person : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Postal Code'
  @sap.quickinfo : 'City postal code'
  PostalCode : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Comm. Method'
  @sap.quickinfo : 'Communication Method (Key) (Business Address Services)'
  PrfrdCommMediumType : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Region'
  @sap.quickinfo : 'Region (State, Province, County)'
  Region : String(3);
  @sap.label : 'Street'
  StreetName : String(60);
  @sap.label : 'Street 2'
  StreetPrefixName : String(40);
  @sap.label : 'Street 4'
  StreetSuffixName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Jurisdiction'
  TaxJurisdiction : String(15);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Transportation Zone'
  @sap.quickinfo : 'Transportation zone to or from which the goods are delivered'
  TransportZone : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Version'
  @sap.quickinfo : 'Version ID for International Addresses'
  AddressRepresentationCode : String(1);
  @sap.label : 'Function'
  ContactRelationshipFunction : String(40);
  @sap.label : 'Department'
  ContactRelationshipDepartment : String(40);
  @sap.label : 'Floor'
  @sap.quickinfo : 'Floor in building'
  Floor : String(10);
  @sap.label : 'Building code'
  @sap.quickinfo : 'Building (number or code)'
  ContactPersonBuilding : String(10);
  @sap.label : 'Room Number'
  @sap.quickinfo : 'Room or Apartment Number'
  RoomNumber : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Comm. Method'
  @sap.quickinfo : 'Communication Method (Key) (Business Address Services)'
  ContactPersonPrfrdCommMedium : String(3);
  @sap.label : 'Short name'
  @sap.quickinfo : 'Short name for correspondence'
  CorrespondenceShortName : String(10);
  @sap.label : 'Internal mail'
  @sap.quickinfo : 'Internal Mail Postal Code'
  InhouseMail : String(10);
  @cds.ambiguous : 'missing on condition?'
  to_EmailAddress : Association to many API_BUSINESS_PARTNER.A_AddressEmailAddress {  };
  @cds.ambiguous : 'missing on condition?'
  to_FaxNumber : Association to many API_BUSINESS_PARTNER.A_AddressFaxNumber {  };
  @cds.ambiguous : 'missing on condition?'
  to_MobilePhoneNumber : Association to many API_BUSINESS_PARTNER.A_AddressPhoneNumber {  };
  @cds.ambiguous : 'missing on condition?'
  to_PhoneNumber : Association to many API_BUSINESS_PARTNER.A_AddressPhoneNumber {  };
  @cds.ambiguous : 'missing on condition?'
  to_URLAddress : Association to many API_BUSINESS_PARTNER.A_AddressHomePageURL {  };
};

@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Function and Department'
entity API_BUSINESS_PARTNER.A_BPContactToFuncAndDept {
  @sap.display.format : 'UpperCase'
  @sap.label : 'BP Relationship No.'
  @sap.quickinfo : 'BP Relationship Number'
  key RelationshipNumber : String(12);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartnerCompany : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartnerPerson : String(10);
  @sap.display.format : 'Date'
  @sap.label : 'Valid To'
  @sap.quickinfo : 'Validity Date (Valid To)'
  key ValidityEndDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Function'
  @sap.quickinfo : 'Function of partner'
  ContactPersonFunction : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Department'
  ContactPersonDepartment : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Telephone'
  @sap.quickinfo : 'Telephone no.: dialling code+number'
  PhoneNumber : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Extension'
  @sap.quickinfo : 'Telephone no.: Extension'
  PhoneNumberExtension : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Fax'
  @sap.quickinfo : 'Fax number: dialling code+number'
  FaxNumber : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Extension'
  @sap.quickinfo : 'Fax no.: Extension'
  FaxNumberExtension : String(10);
  @sap.label : 'E-Mail Address'
  EmailAddress : String(241);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Relationship Cat.'
  @sap.quickinfo : 'Business Partner Relationship Category'
  RelationshipCategory : String(6);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Address Usage'
entity API_BUSINESS_PARTNER.A_BuPaAddressUsage {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartner : String(10);
  @odata.type : 'Edm.DateTimeOffset'
  @odata.precision : 0
  @sap.label : 'Valid To'
  @sap.quickinfo : 'Validity End of a Business Partner Address Usage'
  key ValidityEndDate : DateTime;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Type'
  key AddressUsage : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Number'
  key AddressID : String(10);
  @odata.type : 'Edm.DateTimeOffset'
  @odata.precision : 0
  @sap.label : 'Valid From'
  @sap.quickinfo : 'Validity Start of a Business Partner Address Usage'
  ValidityStartDate : DateTime;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Standard Usage'
  @sap.quickinfo : 'Indicator: Standard Address Usage'
  StandardUsage : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization Group'
  AuthorizationGroup : String(4);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Identification'
entity API_BUSINESS_PARTNER.A_BuPaIdentification {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartner : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Identification Type'
  key BPIdentificationType : String(6);
  @sap.display.format : 'UpperCase'
  @sap.label : 'ID number'
  @sap.quickinfo : 'Identification Number'
  key BPIdentificationNumber : String(60);
  @sap.label : 'Responsible Institn'
  @sap.quickinfo : 'Responsible Institution for ID Number'
  BPIdnNmbrIssuingInstitute : String(40);
  @sap.display.format : 'Date'
  @sap.label : 'Entry date'
  @sap.quickinfo : 'Date of Entry for ID Number'
  BPIdentificationEntryDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Country/Region'
  @sap.quickinfo : 'Country/Region in Which ID Number is Valid or Was Assigned'
  Country : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Region'
  @sap.quickinfo : 'Region (State, Province, County)'
  Region : String(3);
  @sap.display.format : 'Date'
  @sap.label : 'Valid from'
  @sap.quickinfo : 'Validity Start for ID Number'
  ValidityStartDate : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Valid To'
  @sap.quickinfo : 'Validity End for ID Number'
  ValidityEndDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization Group'
  AuthorizationGroup : String(4);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Industry'
entity API_BUSINESS_PARTNER.A_BuPaIndustry {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Industry'
  key IndustrySector : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Industry System'
  key IndustrySystemType : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartner : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Standard Industry'
  @sap.quickinfo : 'Industry is Standard for BP in Industry System'
  IsStandardIndustry : String(1);
  @sap.label : 'Description'
  IndustryKeyDescription : String(100);
};

@cds.persistence.skip : true
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Business Partner'
entity API_BUSINESS_PARTNER.A_BusinessPartner {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartner : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  Supplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Academic Title 1'
  @sap.quickinfo : 'Academic Title: Key'
  AcademicTitle : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'BP Category'
  @sap.quickinfo : 'Business Partner Category'
  BusinessPartnerCategory : String(1);
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  BusinessPartnerFullName : String(81);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Grouping'
  @sap.quickinfo : 'Business Partner Grouping'
  BusinessPartnerGrouping : String(4);
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  BusinessPartnerName : String(81);
  @sap.label : 'BP GUID'
  @sap.quickinfo : 'Business Partner GUID'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  BusinessPartnerUUID : UUID;
  @sap.label : 'Correspondence lang.'
  @sap.quickinfo : 'Business Partner: Correspondence Language'
  CorrespondenceLanguage : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Created by'
  @sap.quickinfo : 'User who created the object'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CreatedByUser : String(12);
  @sap.display.format : 'Date'
  @sap.label : 'Created On'
  @sap.quickinfo : 'Date on which the object was created'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CreationDate : Date;
  @sap.label : 'Created at'
  @sap.quickinfo : 'Time at which the object was created'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CreationTime : Time;
  @sap.label : 'First Name'
  @sap.quickinfo : 'First name of business partner (person)'
  FirstName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Title'
  @sap.quickinfo : 'Form-of-Address Key'
  FormOfAddress : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Industry sector'
  Industry : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Int. location no. 1'
  @sap.quickinfo : 'International location number (part 1)'
  InternationalLocationNumber1 : String(7);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Int. location no. 2'
  @sap.quickinfo : 'International location number (Part 2)'
  InternationalLocationNumber2 : String(5);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Female'
  @sap.quickinfo : 'Selection: Business partner is female'
  IsFemale : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Male'
  @sap.quickinfo : 'Selection: Business partner is male'
  IsMale : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Natural Person'
  @sap.quickinfo : 'Business Partner Is a Natural Person Under the Tax Laws'
  IsNaturalPerson : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Unknown'
  @sap.quickinfo : 'Selection: Sex of business partner is not known'
  IsSexUnknown : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sex'
  @sap.quickinfo : 'Sex of business partner (person)'
  GenderCodeName : String(1);
  @sap.label : 'Language'
  @sap.quickinfo : 'Business partner: Language'
  Language : String(2);
  @sap.display.format : 'Date'
  @sap.label : 'Changed on'
  @sap.quickinfo : 'Date when object was last changed'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  LastChangeDate : Date;
  @sap.label : 'Changed at'
  @sap.quickinfo : 'Time at which object was last changed'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  LastChangeTime : Time;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Changed by'
  @sap.quickinfo : 'Last user to change object'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  LastChangedByUser : String(12);
  @sap.label : 'Last Name'
  @sap.quickinfo : 'Last name of business partner (person)'
  LastName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Legal form'
  @sap.quickinfo : 'BP: Legal form of organization'
  LegalForm : String(2);
  @sap.label : 'Name 1'
  @sap.quickinfo : 'Name 1 of organization'
  OrganizationBPName1 : String(40);
  @sap.label : 'Name 2'
  @sap.quickinfo : 'Name 2 of organization'
  OrganizationBPName2 : String(40);
  @sap.label : 'Name 3'
  @sap.quickinfo : 'Name 3 of organization'
  OrganizationBPName3 : String(40);
  @sap.label : 'Name 4'
  @sap.quickinfo : 'Name 4 of organization'
  OrganizationBPName4 : String(40);
  @sap.display.format : 'Date'
  @sap.label : 'Date founded'
  @sap.quickinfo : 'Date organization founded'
  OrganizationFoundationDate : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Liquidation date'
  @sap.quickinfo : 'Liquidation date of organization'
  OrganizationLiquidationDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Search Term 1'
  @sap.quickinfo : 'Search Term 1 for Business Partner'
  SearchTerm1 : String(20);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Search Term 2'
  @sap.quickinfo : 'Search Term 2 for Business Partner'
  SearchTerm2 : String(20);
  @sap.label : 'Other Last Name'
  @sap.quickinfo : 'Other Last Name of a Person'
  AdditionalLastName : String(40);
  @sap.display.format : 'Date'
  @sap.label : 'Date of Birth'
  @sap.quickinfo : 'Date of Birth of Business Partner'
  BirthDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Birth Date Status'
  @sap.quickinfo : 'Date of Birth: Status'
  BusinessPartnerBirthDateStatus : String(1);
  @sap.label : 'Birthplace'
  @sap.quickinfo : 'Birthplace of business partner'
  BusinessPartnerBirthplaceName : String(40);
  @sap.display.format : 'Date'
  @sap.label : 'Death date'
  @sap.quickinfo : 'Date of death of business partner'
  BusinessPartnerDeathDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Central Block'
  @sap.quickinfo : 'Central Block for Business Partner'
  BusinessPartnerIsBlocked : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'BP Type'
  @sap.quickinfo : 'Business Partner Type'
  BusinessPartnerType : String(4);
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  ETag : String(26);
  @sap.label : 'Name 1'
  @sap.quickinfo : 'Name 1 (group)'
  GroupBusinessPartnerName1 : String(40);
  @sap.label : 'Name 2'
  @sap.quickinfo : 'Name 2 (group)'
  GroupBusinessPartnerName2 : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Number'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  IndependentAddressID : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Check digit'
  @sap.quickinfo : 'Check digit for the international location number'
  InternationalLocationNumber3 : String(1);
  @sap.label : 'Middle Name'
  @sap.quickinfo : 'Middle name or second forename of a person'
  MiddleName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Ctry/Reg. for Format'
  @sap.quickinfo : 'Country/Region for Name Format Rule'
  NameCountry : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Name Format'
  @sap.quickinfo : 'Name format'
  NameFormat : String(2);
  @sap.label : 'Full Name'
  PersonFullName : String(80);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Person Number'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  PersonNumber : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Archiving Flag'
  @sap.quickinfo : 'Central Archiving Flag'
  IsMarkedForArchiving : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'External BP Number'
  @sap.quickinfo : 'Business Partner Number in External System'
  BusinessPartnerIDByExtSystem : String(20);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Trading Partner No.'
  @sap.quickinfo : 'Company ID of Trading Partner'
  TradingPartner : String(6);
  @cds.ambiguous : 'missing on condition?'
  to_BuPaIdentification : Association to many API_BUSINESS_PARTNER.A_BuPaIdentification {  };
  @cds.ambiguous : 'missing on condition?'
  to_BuPaIndustry : Association to many API_BUSINESS_PARTNER.A_BuPaIndustry {  };
  @cds.ambiguous : 'missing on condition?'
  // to_BusinessPartnerAddress : Association to many API_BUSINESS_PARTNER.A_BusinessPartnerAddress {  };
  to_BusinessPartnerAddress: Composition of many API_BUSINESS_PARTNER.A_BusinessPartnerAddress
    on to_BusinessPartnerAddress.BusinessPartner = BusinessPartner;
  @cds.ambiguous : 'missing on condition?'
  to_BusinessPartnerBank : Association to many API_BUSINESS_PARTNER.A_BusinessPartnerBank {  };
  @cds.ambiguous : 'missing on condition?'
  to_BusinessPartnerContact : Association to many API_BUSINESS_PARTNER.A_BusinessPartnerContact {  };
  @cds.ambiguous : 'missing on condition?'
  to_BusinessPartnerRole : Association to many API_BUSINESS_PARTNER.A_BusinessPartnerRole {  };
  @cds.ambiguous : 'missing on condition?'
  to_BusinessPartnerTax : Association to many API_BUSINESS_PARTNER.A_BusinessPartnerTaxNumber {  };
  @cds.ambiguous : 'missing on condition?'
  to_Customer : 
  // Association to API_BUSINESS_PARTNER.A_Customer {  };
  Composition of one API_BUSINESS_PARTNER.A_Customer
    on to_Customer.Customer = BusinessPartner;
  @cds.ambiguous : 'missing on condition?'
  to_Supplier : Association to API_BUSINESS_PARTNER.A_Supplier {  };
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Address'
entity API_BUSINESS_PARTNER.A_BusinessPartnerAddress {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartner : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Address Number'
  key AddressID : String(10);
  @odata.type : 'Edm.DateTimeOffset'
  @odata.precision : 0
  @sap.label : 'Valid From'
  @sap.quickinfo : 'Validity Start of a Business Partner Address'
  ValidityStartDate : DateTime;
  @odata.type : 'Edm.DateTimeOffset'
  @odata.precision : 0
  @sap.label : 'Valid To'
  @sap.quickinfo : 'Validity End of a Business Partner Address'
  ValidityEndDate : DateTime;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.label : 'GUID of a Business Partner Address'
  @sap.heading : ''
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  AddressUUID : UUID;
  @sap.label : 'Street 3'
  AdditionalStreetPrefixName : String(40);
  @sap.label : 'Street 5'
  AdditionalStreetSuffixName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Time zone'
  @sap.quickinfo : 'Address time zone'
  AddressTimeZone : String(6);
  @sap.label : 'c/o'
  @sap.quickinfo : 'c/o name'
  CareOfName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'City Code'
  @sap.quickinfo : 'City code for city/street file'
  CityCode : String(12);
  @sap.label : 'City'
  CityName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Postal Code'
  @sap.quickinfo : 'Company Postal Code (for Large Customers)'
  CompanyPostalCode : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Country/Region Key'
  Country : String(3);
  @sap.label : 'County'
  County : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Delivery Service No.'
  @sap.quickinfo : 'Number of Delivery Service'
  DeliveryServiceNumber : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Delvry Serv Type'
  @sap.quickinfo : 'Type of Delivery Service'
  DeliveryServiceTypeCode : String(4);
  @sap.label : 'District'
  District : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Title'
  @sap.quickinfo : 'Form-of-Address Key'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  FormOfAddress : String(4);
  @sap.label : 'Full Name'
  @sap.quickinfo : 'Full name of a party (Bus. Partner, Org. Unit, Doc. address)'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  FullName : String(80);
  @sap.label : 'Different City'
  @sap.quickinfo : 'City (different from postal city)'
  HomeCityName : String(40);
  @sap.label : 'House Number'
  HouseNumber : String(10);
  @sap.label : 'Supplement'
  @sap.quickinfo : 'House number supplement'
  HouseNumberSupplementText : String(10);
  @sap.label : 'Language Key'
  Language : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'PO Box'
  POBox : String(10);
  @sap.label : 'PO Box City'
  @sap.quickinfo : 'PO Box city'
  POBoxDeviatingCityName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'PO Box Ctry/Region'
  @sap.quickinfo : 'PO Box of Country/Region'
  POBoxDeviatingCountry : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'PO Box Region'
  @sap.quickinfo : 'Region for PO Box (Country, State, Province, ...)'
  POBoxDeviatingRegion : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'PO Box w/o No.'
  @sap.quickinfo : 'Flag: PO Box Without Number'
  POBoxIsWithoutNumber : Boolean;
  @sap.label : 'PO Box Lobby'
  POBoxLobbyName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'PO Box Postal Code'
  POBoxPostalCode : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Person Number'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  Person : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Postal Code'
  @sap.quickinfo : 'City postal code'
  PostalCode : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Comm. Method'
  @sap.quickinfo : 'Communication Method (Key) (Business Address Services)'
  PrfrdCommMediumType : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Region'
  @sap.quickinfo : 'Region (State, Province, County)'
  Region : String(3);
  @sap.label : 'Street'
  StreetName : String(60);
  @sap.label : 'Street 2'
  StreetPrefixName : String(40);
  @sap.label : 'Street 4'
  StreetSuffixName : String(40);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Jurisdiction'
  TaxJurisdiction : String(15);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Transportation Zone'
  @sap.quickinfo : 'Transportation zone to or from which the goods are delivered'
  TransportZone : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'External Address No.'
  @sap.quickinfo : 'Address number in external system'
  AddressIDByExternalSystem : String(20);
  @sap.display.format : 'UpperCase'
  @sap.label : 'County code'
  @sap.quickinfo : 'County code for county'
  CountyCode : String(8);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Township code'
  @sap.quickinfo : 'Township code for Township'
  TownshipCode : String(8);
  @sap.label : 'Township'
  TownshipName : String(40);
  @cds.ambiguous : 'missing on condition?'
  to_AddressUsage : Association to many API_BUSINESS_PARTNER.A_BuPaAddressUsage {  };
  @cds.ambiguous : 'missing on condition?'
  to_EmailAddress : 
  // Association to many API_BUSINESS_PARTNER.A_AddressEmailAddress {  };
  Composition of many API_BUSINESS_PARTNER.A_AddressEmailAddress
    on to_EmailAddress.AddressID = AddressID;
  @cds.ambiguous : 'missing on condition?'
  to_FaxNumber : Association to many API_BUSINESS_PARTNER.A_AddressFaxNumber {  };
  @cds.ambiguous : 'missing on condition?'
  to_MobilePhoneNumber : Association to many API_BUSINESS_PARTNER.A_AddressPhoneNumber {  };
  @cds.ambiguous : 'missing on condition?'
  to_PhoneNumber : 
  // Association to many API_BUSINESS_PARTNER.A_AddressPhoneNumber {  };
  Association to many API_BUSINESS_PARTNER.A_AddressPhoneNumber
    on to_PhoneNumber.AddressID = AddressID;
  @cds.ambiguous : 'missing on condition?'
  to_URLAddress : Association to many API_BUSINESS_PARTNER.A_AddressHomePageURL {  };
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Bank'
entity API_BUSINESS_PARTNER.A_BusinessPartnerBank {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartner : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Bank details ID'
  key BankIdentification : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Bank Country/Region'
  @sap.quickinfo : 'Country/Region Key of Bank'
  BankCountryKey : String(3);
  @sap.label : 'Bank name'
  @sap.quickinfo : 'Name of bank'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  BankName : String(60);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Bank Key'
  BankNumber : String(15);
  @sap.display.format : 'UpperCase'
  @sap.label : 'SWIFT/BIC'
  @sap.quickinfo : 'SWIFT/BIC for International Payments'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  SWIFTCode : String(11);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Bank Control Key'
  BankControlKey : String(2);
  @sap.label : 'Account Holder'
  @sap.quickinfo : 'Account Holder Name'
  BankAccountHolderName : String(60);
  @sap.label : 'Account Name'
  @sap.quickinfo : 'Name of Bank Account'
  BankAccountName : String(40);
  @odata.type : 'Edm.DateTimeOffset'
  @odata.precision : 0
  @sap.label : 'Valid From'
  @sap.quickinfo : 'Validity Start of Business Partner Bank Details'
  ValidityStartDate : DateTime;
  @odata.type : 'Edm.DateTimeOffset'
  @odata.precision : 0
  @sap.label : 'Valid To'
  @sap.quickinfo : 'Validity End of Business Partner Bank Details'
  ValidityEndDate : DateTime;
  @sap.display.format : 'UpperCase'
  @sap.label : 'IBAN'
  @sap.quickinfo : 'IBAN (International Bank Account Number)'
  IBAN : String(34);
  @sap.display.format : 'Date'
  @sap.label : 'IBAN valid from'
  @sap.quickinfo : 'Validity start of IBAN'
  IBANValidityStartDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Bank acct'
  @sap.quickinfo : 'Bank Account Number'
  BankAccount : String(18);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Reference Details'
  @sap.quickinfo : 'Reference Details for Bank Details'
  BankAccountReferenceText : String(20);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Collect.author.'
  @sap.quickinfo : 'Indicator: Collection Authorization'
  CollectionAuthInd : Boolean;
  @sap.label : 'City'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CityName : String(35);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization Group'
  AuthorizationGroup : String(4);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Contact'
entity API_BUSINESS_PARTNER.A_BusinessPartnerContact {
  @sap.display.format : 'UpperCase'
  @sap.label : 'BP Relationship No.'
  @sap.quickinfo : 'BP Relationship Number'
  key RelationshipNumber : String(12);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartnerCompany : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartnerPerson : String(10);
  @sap.display.format : 'Date'
  @sap.label : 'Valid To'
  @sap.quickinfo : 'Validity Date (Valid To)'
  key ValidityEndDate : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Valid From'
  @sap.quickinfo : 'Validity Date (Valid From)'
  ValidityStartDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Standard'
  @sap.quickinfo : 'Standard Relationship'
  IsStandardRelationship : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Relationship Cat.'
  @sap.quickinfo : 'Business Partner Relationship Category'
  RelationshipCategory : String(6);
  @cds.ambiguous : 'missing on condition?'
  to_ContactAddress : Association to many API_BUSINESS_PARTNER.A_BPContactToAddress {  };
  @cds.ambiguous : 'missing on condition?'
  to_ContactRelationship : Association to API_BUSINESS_PARTNER.A_BPContactToFuncAndDept {  };
};

@cds.persistence.skip : true
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Role'
entity API_BUSINESS_PARTNER.A_BusinessPartnerRole {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartner : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'BP Role'
  key BusinessPartnerRole : String(6);
  @odata.type : 'Edm.DateTimeOffset'
  @odata.precision : 0
  @sap.label : 'Valid From'
  @sap.quickinfo : 'Validity Start of a BP Role'
  ValidFrom : DateTime;
  @odata.type : 'Edm.DateTimeOffset'
  @odata.precision : 0
  @sap.label : 'Valid To'
  @sap.quickinfo : 'Validity End of a BP Role'
  ValidTo : DateTime;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization Group'
  AuthorizationGroup : String(4);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Tax Number'
entity API_BUSINESS_PARTNER.A_BusinessPartnerTaxNumber {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  key BusinessPartner : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number Category'
  key BPTaxType : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax number'
  @sap.quickinfo : 'Business Partner Tax Number'
  BPTaxNumber : String(20);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number'
  @sap.quickinfo : 'Business Partner Tax Number'
  BPTaxLongNumber : String(60);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization Group'
  AuthorizationGroup : String(4);
};

@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Customer'
entity API_BUSINESS_PARTNER.A_Customer {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  key Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Billing block'
  @sap.quickinfo : 'Central billing block for customer'
  BillingIsBlockedForCustomer : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Created by'
  @sap.quickinfo : 'Name of Person who Created the Object'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CreatedByUser : String(12);
  @sap.display.format : 'Date'
  @sap.label : 'Created On'
  @sap.quickinfo : 'Date on which the Record Was Created'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CreationDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account group'
  @sap.quickinfo : 'Customer Account Group'
  CustomerAccountGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer Classific.'
  @sap.quickinfo : 'Customer Classification'
  CustomerClassification : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer Name'
  @sap.quickinfo : 'Customer Full Name'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CustomerFullName : String(220);
  @sap.label : 'Name of Customer'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CustomerName : String(80);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Delivery block'
  @sap.quickinfo : 'Central delivery block for the customer'
  DeliveryIsBlocked : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Natural Person'
  NFPartnerIsNaturalPerson : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Order block'
  @sap.quickinfo : 'Central order block for customer'
  OrderIsBlockedForCustomer : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Posting Block'
  @sap.quickinfo : 'Central posting block'
  PostingIsBlocked : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  Supplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Group key'
  CustomerCorporateGroup : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Fiscal address'
  @sap.quickinfo : 'Account number of the master record with the fiscal address'
  FiscalAddress : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Industry'
  @sap.quickinfo : 'Industry key'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  Industry : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Industry code 1'
  IndustryCode1 : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Industry code 2'
  IndustryCode2 : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Industry code 3'
  IndustryCode3 : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Industry code 4'
  IndustryCode4 : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Industry code 5'
  IndustryCode5 : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Int. location no. 1'
  @sap.quickinfo : 'International location number (part 1)'
  InternationalLocationNumber1 : String(7);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Nielsen indicator'
  @sap.quickinfo : 'Nielsen ID'
  NielsenRegion : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Type'
  ResponsibleType : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number 1'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  TaxNumber1 : String(16);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number 2'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  TaxNumber2 : String(11);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number 3'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  TaxNumber3 : String(18);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number 4'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  TaxNumber4 : String(18);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number 5'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  TaxNumber5 : String(60);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax number type'
  @sap.quickinfo : 'Tax Number Type'
  TaxNumberType : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'VAT Registration No.'
  @sap.quickinfo : 'VAT Registration Number'
  VATRegistration : String(20);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Deletion flag'
  @sap.quickinfo : 'Central Deletion Flag for Master Record'
  DeletionIndicator : Boolean;
  @sap.label : 'Express station'
  @sap.quickinfo : 'Express train station'
  ExpressTrainStationName : String(25);
  @sap.label : 'Train station'
  TrainStationName : String(25);
  @sap.display.format : 'UpperCase'
  @sap.label : 'City Code'
  CityCode : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'County Code'
  County : String(3);
  @cds.ambiguous : 'missing on condition?'
  to_CustomerCompany : Association to many API_BUSINESS_PARTNER.A_CustomerCompany {  };
  @cds.ambiguous : 'missing on condition?'
  to_CustomerSalesArea : Association to many API_BUSINESS_PARTNER.A_CustomerSalesArea {  };
  @cds.ambiguous : 'missing on condition?'
  to_CustomerTaxGrouping : Association to many API_BUSINESS_PARTNER.A_CustomerTaxGrouping {  };
  @cds.ambiguous : 'missing on condition?'
  to_CustomerText : Association to many API_BUSINESS_PARTNER.A_CustomerText {  };
  @cds.ambiguous : 'missing on condition?'
  to_CustomerUnloadingPoint : 
  // Association to many API_BUSINESS_PARTNER.A_CustomerUnloadingPoint {  };
  Composition of many API_BUSINESS_PARTNER.A_CustomerUnloadingPoint on to_CustomerUnloadingPoint.Customer=Customer;
};

@cds.persistence.skip : true
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Customer Company'
entity API_BUSINESS_PARTNER.A_CustomerCompany {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  key Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Code'
  key CompanyCode : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tolerance Group'
  @sap.quickinfo : 'Tolerance Group for Business Partner/G/L Account'
  APARToleranceGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account at customer'
  @sap.quickinfo : 'Our account number at customer'
  AccountByCustomer : String(12);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Clerk Abbrev.'
  @sap.quickinfo : 'Accounting Clerk Abbreviation'
  AccountingClerk : String(2);
  @sap.label : 'Acctg clerk''s fax'
  @sap.quickinfo : 'Accounting clerk''s fax number at the customer/vendor'
  AccountingClerkFaxNumber : String(31);
  @sap.label : 'Clrk''s internet add.'
  @sap.quickinfo : 'Internet address of partner company clerk'
  AccountingClerkInternetAddress : String(130);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Acct.clerks tel.no.'
  @sap.quickinfo : 'Accounting clerk''s telephone number at business partner'
  AccountingClerkPhoneNumber : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Alternative payer'
  @sap.quickinfo : 'Account number of an alternative payer'
  AlternativePayerAccount : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Coll.Invoice Variant'
  @sap.quickinfo : 'Collective Invoice Variant'
  CollectiveInvoiceVariant : String(1);
  @sap.label : 'Account Memo'
  @sap.quickinfo : 'Memo'
  CustomerAccountNote : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Head office'
  @sap.quickinfo : 'Head office account number (in branch accounts)'
  CustomerHeadOffice : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Clearing with vendor'
  @sap.quickinfo : 'Indicator: Clearing between customer and vendor ?'
  CustomerSupplierClearingIsUsed : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'House Bank'
  @sap.quickinfo : 'Short Key for a House Bank'
  HouseBank : String(5);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Interest indicator'
  @sap.quickinfo : 'Interest Indicator'
  InterestCalculationCode : String(2);
  @sap.display.format : 'Date'
  @sap.label : 'Last Key Date'
  @sap.quickinfo : 'Key Date of Last Interest Calculation'
  InterestCalculationDate : Date;
  @sap.display.format : 'NonNegative'
  @sap.label : 'Int.Calc.Freq.'
  @sap.quickinfo : 'Interest Calculation Frequency in Months'
  IntrstCalcFrequencyInMonths : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Local Processing'
  @sap.quickinfo : 'Indicator: Local Processing?'
  IsToBeLocallyProcessed : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Individual Payment'
  @sap.quickinfo : 'Indicator: Pay All Items Separately?'
  ItemIsToBePaidSeparately : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sort key'
  @sap.quickinfo : 'Key for sorting according to assignment numbers'
  LayoutSortingRule : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Payment Block'
  @sap.quickinfo : 'Block Key for Payment'
  PaymentBlockingReason : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Payment Methods'
  @sap.quickinfo : 'List of Respected Payment Methods'
  PaymentMethodsList : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Payment Terms'
  @sap.quickinfo : 'Terms of Payment Key'
  PaymentTerms : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Pmnt advice by EDI'
  @sap.quickinfo : 'Indicator: Send Payment Advices by EDI'
  PaytAdviceIsSentbyEDI : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Co.code post.block'
  @sap.quickinfo : 'Posting block for company code'
  PhysicalInventoryBlockInd : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Reconciliation acct'
  @sap.quickinfo : 'Reconciliation Account in General Ledger'
  ReconciliationAccount : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Record pmnt history'
  @sap.quickinfo : 'Indicator: Record Payment History ?'
  RecordPaymentHistoryIndicator : Boolean;
  @sap.label : 'User at customer'
  UserAtCustomer : String(15);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Co.cde deletion flag'
  @sap.quickinfo : 'Deletion Flag for Master Record (Company Code Level)'
  DeletionIndicator : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Planning Group'
  CashPlanningGroup : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Known/Negotiat.Leave'
  @sap.quickinfo : 'Short Key for Known/Negotiated Leave'
  KnownOrNegotiatedLeave : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Value Adjustment'
  @sap.quickinfo : 'Value Adjustment Key'
  ValueAdjustmentKey : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account group'
  @sap.quickinfo : 'Customer Account Group'
  CustomerAccountGroup : String(4);
  @cds.ambiguous : 'missing on condition?'
  to_CompanyText : Association to many API_BUSINESS_PARTNER.A_CustomerCompanyText {  };
  @cds.ambiguous : 'missing on condition?'
  to_CustomerDunning : Association to many API_BUSINESS_PARTNER.A_CustomerDunning {  };
  @cds.ambiguous : 'missing on condition?'
  to_WithHoldingTax : Association to many API_BUSINESS_PARTNER.A_CustomerWithHoldingTax {  };
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Customer Company Text'
entity API_BUSINESS_PARTNER.A_CustomerCompanyText {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  key Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Code'
  key CompanyCode : String(4);
  @sap.label : 'Language'
  @sap.quickinfo : 'Language key'
  key Language : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Text ID'
  key LongTextID : String(4);
  @sap.label : 'String'
  @sap.heading : ''
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  LongText : LargeString;
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Customer Dunning'
entity API_BUSINESS_PARTNER.A_CustomerDunning {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  key Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Code'
  key CompanyCode : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Dunning Area'
  key DunningArea : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Dunning Block'
  DunningBlock : String(1);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Dunning Level'
  DunningLevel : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Dunning Procedure'
  DunningProcedure : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Dunning Recipient'
  @sap.quickinfo : 'Account Number of the Dunning Recipient'
  DunningRecipient : String(10);
  @sap.display.format : 'Date'
  @sap.label : 'Last Dunned'
  @sap.quickinfo : 'Date of Last Dunning Notice'
  LastDunnedOn : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Legal Dunn.Proc.From'
  @sap.quickinfo : 'Date of the Legal Dunning Proceedings'
  LegDunningProcedureOn : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Dunning Clerk'
  DunningClerk : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account group'
  @sap.quickinfo : 'Customer Account Group'
  CustomerAccountGroup : String(4);
};

@cds.persistence.skip : true
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Sales Area'
entity API_BUSINESS_PARTNER.A_CustomerSalesArea {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  key Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sales Organization'
  key SalesOrganization : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Distribution Channel'
  key DistributionChannel : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Division'
  key Division : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account at customer'
  @sap.quickinfo : 'Shipper''s (Our) Account Number at the Customer or Vendor'
  AccountByCustomer : String(12);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'BBlock for SlsA'
  @sap.quickinfo : 'Billing block for customer (sales and distribution)'
  BillingIsBlockedForCustomer : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Complete Delivery'
  @sap.quickinfo : 'Complete Delivery Defined for Each Sales Order?'
  CompleteDeliveryIsDefined : Boolean;
  @sap.label : 'Currency'
  @sap.semantics : 'currency-code'
  Currency : String(5);
  @sap.display.format : 'UpperCase'
  @sap.label : 'ABC Classification'
  @sap.quickinfo : 'Customer classification (ABC analysis)'
  CustomerABCClassification : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Acct Assmt Grp Cust.'
  @sap.quickinfo : 'Account Assignment Group for this Customer'
  CustomerAccountAssignmentGroup : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer Group'
  CustomerGroup : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Payment Terms'
  @sap.quickinfo : 'Terms of Payment Key'
  CustomerPaymentTerms : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer Price Group'
  CustomerPriceGroup : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Cust.Pric.Procedure'
  @sap.quickinfo : 'Customer Classification for Pricing Procedure Determination'
  CustomerPricingProcedure : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'DelBlckSalesAr.'
  @sap.quickinfo : 'Customer delivery block (sales area)'
  DeliveryIsBlockedForCustomer : String(2);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Delivery Priority'
  DeliveryPriority : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Incoterms'
  @sap.quickinfo : 'Incoterms (Part 1)'
  IncotermsClassification : String(3);
  @sap.label : 'Incoterms Location 2'
  IncotermsLocation2 : String(70);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Incoterms Version'
  IncotermsVersion : String(4);
  @sap.label : 'Incoterms Location 1'
  IncotermsLocation1 : String(70);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Del.ID SlsArea'
  @sap.quickinfo : 'Deletion flag for customer (sales level)'
  DeletionIndicator : Boolean;
  @sap.label : 'Incoterms (Part 2)'
  IncotermsTransferLocation : String(28);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Invoicing Dates'
  @sap.quickinfo : 'Invoice Dates (Calendar Identification)'
  InvoiceDate : String(2);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Order Probability'
  @sap.quickinfo : 'Order Probability of the Item'
  ItemOrderProbabilityInPercent : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Order Combination'
  @sap.quickinfo : 'Order Combination Indicator'
  OrderCombinationIsAllowed : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Ord.blk:sls ar.'
  @sap.quickinfo : 'Customer order block (sales area)'
  OrderIsBlockedForCustomer : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Part.dlv./item'
  @sap.quickinfo : 'Partial delivery at item level'
  PartialDeliveryIsAllowed : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Price List Type'
  PriceListType : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sales Group'
  SalesGroup : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sales Office'
  SalesOffice : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Shipping Conditions'
  ShippingCondition : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Delivering Plant'
  @sap.quickinfo : 'Delivering Plant (Own or External)'
  SupplyingPlant : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sales District'
  SalesDistrict : String(6);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Invoice List Sched.'
  @sap.quickinfo : 'Invoice List Schedule (calendar identification)'
  InvoiceListSchedule : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Exchange Rate Type'
  ExchangeRateType : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer Group 1'
  AdditionalCustomerGroup1 : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer Group 2'
  AdditionalCustomerGroup2 : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer Group 3'
  AdditionalCustomerGroup3 : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer Group 4'
  AdditionalCustomerGroup4 : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer Group 5'
  AdditionalCustomerGroup5 : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Paymt guarant. proc.'
  @sap.quickinfo : 'Customer payment guarantee procedure'
  PaymentGuaranteeProcedure : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account group'
  @sap.quickinfo : 'Customer Account Group'
  CustomerAccountGroup : String(4);
  @cds.ambiguous : 'missing on condition?'
  to_PartnerFunction : Association to many API_BUSINESS_PARTNER.A_CustSalesPartnerFunc {  };
  @cds.ambiguous : 'missing on condition?'
  to_SalesAreaTax : Association to many API_BUSINESS_PARTNER.A_CustomerSalesAreaTax {  };
  @cds.ambiguous : 'missing on condition?'
  to_SalesAreaText : Association to many API_BUSINESS_PARTNER.A_CustomerSalesAreaText {  };
};

@cds.persistence.skip : true
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Sales Area Tax'
entity API_BUSINESS_PARTNER.A_CustomerSalesAreaTax {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  key Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sales Organization'
  key SalesOrganization : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'RefDistCh-Cust/Mat.'
  @sap.quickinfo : 'Reference distrib.channel for cust.and material masters'
  key DistributionChannel : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Division'
  key Division : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Departure Ctry/Reg.'
  @sap.quickinfo : 'Departure Country/Region (from which the goods are sent)'
  key DepartureCountry : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Category'
  @sap.quickinfo : 'Tax category (sales tax, federal sales tax,...)'
  key CustomerTaxCategory : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Classification'
  @sap.quickinfo : 'Tax classification for customer'
  CustomerTaxClassification : String(1);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Customer Sales Area Text'
entity API_BUSINESS_PARTNER.A_CustomerSalesAreaText {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  key Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sales Organization'
  key SalesOrganization : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Distribution Channel'
  key DistributionChannel : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Division'
  key Division : String(2);
  @sap.label : 'Language'
  @sap.quickinfo : 'Language key'
  key Language : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Text ID'
  key LongTextID : String(4);
  @sap.label : 'String'
  @sap.heading : ''
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  LongText : LargeString;
};

@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.content.version : '1'
@sap.label : 'Customer Tax Grouping'
entity API_BUSINESS_PARTNER.A_CustomerTaxGrouping {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  key Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Category'
  @sap.quickinfo : 'Category Indicator for Tax Codes'
  key CustomerTaxGroupingCode : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Exempt. Number'
  @sap.quickinfo : 'Number of exemption certificate'
  CustTaxGrpExemptionCertificate : String(15);
  @sap.label : 'Exemption Rate'
  @sap.quickinfo : 'Exemption rate'
  CustTaxGroupExemptionRate : Decimal(5, 2);
  @sap.display.format : 'Date'
  @sap.label : 'Exempted from'
  @sap.quickinfo : 'Start date of exemption'
  CustTaxGroupExemptionStartDate : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Exempted until'
  @sap.quickinfo : 'End date of exemption'
  CustTaxGroupExemptionEndDate : Date;
  @sap.display.format : 'Date'
  @sap.label : 'subjected from'
  @sap.quickinfo : 'Subjected from'
  CustTaxGroupSubjectedStartDate : Date;
  @sap.display.format : 'Date'
  @sap.label : 'subjected until'
  @sap.quickinfo : 'Subjected until'
  CustTaxGroupSubjectedEndDate : Date;
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Customer Text'
entity API_BUSINESS_PARTNER.A_CustomerText {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  key Customer : String(10);
  @sap.label : 'Language'
  @sap.quickinfo : 'Language key'
  key Language : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Text ID'
  key LongTextID : String(4);
  @sap.label : 'String'
  @sap.heading : ''
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  LongText : LargeString;
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Customer Unloading Point'
entity API_BUSINESS_PARTNER.A_CustomerUnloadingPoint {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  key Customer : String(10);
  @sap.label : 'Unloading Point'
  key UnloadingPointName : String(25);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Cust.fact.calendar'
  @sap.quickinfo : 'Customer''s factory calendar'
  CustomerFactoryCalenderCode : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Goods receiving hrs'
  @sap.quickinfo : 'Goods receiving hours ID (default value)'
  BPGoodsReceivingHoursCode : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Default unloading pt'
  @sap.quickinfo : 'Default unloading point'
  IsDfltBPUnloadingPoint : Boolean;
  @sap.label : 'Monday'
  @sap.quickinfo : 'Goods receipt times: Monday morning from ...'
  MondayMorningOpeningTime : Time;
  @sap.label : 'Monday'
  @sap.quickinfo : 'Goods receiving hours: Monday morning until ...'
  MondayMorningClosingTime : Time;
  @sap.label : 'Monday'
  @sap.quickinfo : 'Goods receiving hours: Monday afternoon from ...'
  MondayAfternoonOpeningTime : Time;
  @sap.label : 'Monday'
  @sap.quickinfo : 'Goods receiving hours: Monday afternoon until ...'
  MondayAfternoonClosingTime : Time;
  @sap.label : 'Tuesday'
  @sap.quickinfo : 'Goods receiving hours: Tuesday morning from...'
  TuesdayMorningOpeningTime : Time;
  @sap.label : 'Tuesday'
  @sap.quickinfo : 'Goods receipt times: Tuesday morning until ...'
  TuesdayMorningClosingTime : Time;
  @sap.label : 'Tuesday'
  @sap.quickinfo : 'Goods receiving hours: Tuesday afternoon from ...'
  TuesdayAfternoonOpeningTime : Time;
  @sap.label : 'Tuesday'
  @sap.quickinfo : 'Goods receiving hours: Tuesday afternoon until ...'
  TuesdayAfternoonClosingTime : Time;
  @sap.label : 'Wednesday'
  @sap.quickinfo : 'Goods receiving hours: Wednesday morning from ...'
  WednesdayMorningOpeningTime : Time;
  @sap.label : 'Wednesday'
  @sap.quickinfo : 'Goods receiving hours: Wednesday morning until ...'
  WednesdayMorningClosingTime : Time;
  @sap.label : 'Wednesday'
  @sap.quickinfo : 'Goods receiving hours: Wednesday afternoon from ...'
  WednesdayAfternoonOpeningTime : Time;
  @sap.label : 'Wednesday'
  @sap.quickinfo : 'Goods receiving hours: Wednesday afternoon until ...'
  WednesdayAfternoonClosingTime : Time;
  @sap.label : 'Thursday'
  @sap.quickinfo : 'Goods receiving hours: Thursday morning from ...'
  ThursdayMorningOpeningTime : Time;
  @sap.label : 'Thursday'
  @sap.quickinfo : 'Goods receiving hours: Thursday morning until ...'
  ThursdayMorningClosingTime : Time;
  @sap.label : 'Thursday'
  @sap.quickinfo : 'Goods receiving hours: Thursday afternoon from ...'
  ThursdayAfternoonOpeningTime : Time;
  @sap.label : 'Thursday'
  @sap.quickinfo : 'Goods receiving hours: Thursday afternoon until...'
  ThursdayAfternoonClosingTime : Time;
  @sap.label : 'Friday'
  @sap.quickinfo : 'Goods receiving hours: Friday morning from ...'
  FridayMorningOpeningTime : Time;
  @sap.label : 'Friday'
  @sap.quickinfo : 'Goods receiving hours: Friday morning until ...'
  FridayMorningClosingTime : Time;
  @sap.label : 'Friday'
  @sap.quickinfo : 'Goods receiving hours: Friday afternoon from ...'
  FridayAfternoonOpeningTime : Time;
  @sap.label : 'Friday'
  @sap.quickinfo : 'Goods receiving hours: Friday afternoon until ...'
  FridayAfternoonClosingTime : Time;
  @sap.label : 'Saturday'
  @sap.quickinfo : 'Goods receiving hours: Saturday morning from ...'
  SaturdayMorningOpeningTime : Time;
  @sap.label : 'Saturday'
  @sap.quickinfo : 'Goods receiving hours: Saturday morning from ...'
  SaturdayMorningClosingTime : Time;
  @sap.label : 'Saturday'
  @sap.quickinfo : 'Goods receiving hours: Saturday afternoon from ...'
  SaturdayAfternoonOpeningTime : Time;
  @sap.label : 'Saturday'
  @sap.quickinfo : 'Goods receiving hours: Saturday afternoon until ...'
  SaturdayAfternoonClosingTime : Time;
  @sap.label : 'Sunday'
  @sap.quickinfo : 'Goods receiving hours: Sunday morning from ...'
  SundayMorningOpeningTime : Time;
  @sap.label : 'Sunday'
  @sap.quickinfo : 'Goods receiving hours: Sunday morning until ...'
  SundayMorningClosingTime : Time;
  @sap.label : 'Sunday'
  @sap.quickinfo : 'Goods receiving hours: Sunday afternoon from ...'
  SundayAfternoonOpeningTime : Time;
  @sap.label : 'Sunday'
  @sap.quickinfo : 'Goods receiving hours: Sunday afternoon until ...'
  SundayAfternoonClosingTime : Time;
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Withholding Tax'
entity API_BUSINESS_PARTNER.A_CustomerWithHoldingTax {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  key Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Code'
  key CompanyCode : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Withholding Tax Type'
  @sap.quickinfo : 'Indicator for Withholding Tax Type'
  key WithholdingTaxType : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'W/Tax Code'
  @sap.quickinfo : 'Withholding Tax Code'
  WithholdingTaxCode : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'WTax Agent'
  @sap.quickinfo : 'Indicator: Withholding Tax Agent?'
  WithholdingTaxAgent : Boolean;
  @sap.display.format : 'Date'
  @sap.label : 'W/Tax Obligated Frm'
  @sap.quickinfo : 'Obligated to Withhold Tax From'
  ObligationDateBegin : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Oblig.to W/Tax Until'
  @sap.quickinfo : 'Obligated to Withhold Tax Until'
  ObligationDateEnd : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'W/tax number'
  @sap.quickinfo : 'Withholding tax identification number'
  WithholdingTaxNumber : String(16);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Exemption Number'
  @sap.quickinfo : 'Exemption Certificate Number'
  WithholdingTaxCertificate : String(25);
  @sap.label : 'Exemption Rate'
  WithholdingTaxExmptPercent : Decimal(5, 2);
  @sap.display.format : 'Date'
  @sap.label : 'Exemption Start Date'
  @sap.quickinfo : 'Date on Which Exemption Begins'
  ExemptionDateBegin : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Exemption End Date'
  @sap.quickinfo : 'Date on Which Exemption Ends'
  ExemptionDateEnd : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Exemption Reason'
  @sap.quickinfo : 'Reason for Exemption'
  ExemptionReason : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Sales Partner Functions'
entity API_BUSINESS_PARTNER.A_CustSalesPartnerFunc {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  key Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sales Organization'
  key SalesOrganization : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Distribution Channel'
  key DistributionChannel : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Division'
  key Division : String(2);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Partner counter'
  key PartnerCounter : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Partner Function'
  key PartnerFunction : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer number of business partner'
  BPCustomerNumber : String(10);
  @sap.label : 'Partner description'
  @sap.quickinfo : 'Customer description of partner (plant, storage location)'
  CustomerPartnerDescription : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Default Partner'
  DefaultPartner : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  Supplier : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Personnel Number'
  PersonnelNumber : String(8);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Contact Person'
  @sap.quickinfo : 'Number of Contact Person'
  ContactPerson : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
};

@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Supplier'
entity API_BUSINESS_PARTNER.A_Supplier {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  key Supplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Alternative Payee'
  @sap.quickinfo : 'Account Number of the Alternative Payee'
  AlternativePayeeAccountNumber : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Created by'
  @sap.quickinfo : 'Name of Person who Created the Object'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CreatedByUser : String(12);
  @sap.display.format : 'Date'
  @sap.label : 'Created On'
  @sap.quickinfo : 'Date on which the Record Was Created'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CreationDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Customer'
  @sap.quickinfo : 'Customer Number'
  Customer : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Payment block'
  @sap.quickinfo : 'Payment Block'
  PaymentIsBlockedForSupplier : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Posting Block'
  @sap.quickinfo : 'Central posting block'
  PostingIsBlocked : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Purch. block'
  @sap.quickinfo : 'Centrally imposed purchasing block'
  PurchasingIsBlocked : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account group'
  @sap.quickinfo : 'Vendor account group'
  SupplierAccountGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier Name'
  @sap.quickinfo : 'Supplier Full Name'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  SupplierFullName : String(220);
  @sap.label : 'Name of Supplier'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  SupplierName : String(80);
  @sap.display.format : 'UpperCase'
  @sap.label : 'VAT Registration No.'
  @sap.quickinfo : 'VAT Registration Number'
  VATRegistration : String(20);
  @sap.display.format : 'Date'
  @sap.label : 'Date of Birth'
  @sap.quickinfo : 'Date of Birth of the Person Subject to Withholding Tax'
  BirthDate : Date;
  @sap.label : 'Int. Location No.'
  @sap.quickinfo : 'Cocatenated International Location Number'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  ConcatenatedInternationalLocNo : String(20);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Deletion flag'
  @sap.quickinfo : 'Central Deletion Flag for Master Record'
  DeletionIndicator : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Fiscal address'
  @sap.quickinfo : 'Account number of the master record with fiscal address'
  FiscalAddress : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Industry'
  @sap.quickinfo : 'Industry key'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  Industry : String(4);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Int. location no. 1'
  @sap.quickinfo : 'International location number (part 1)'
  InternationalLocationNumber1 : String(7);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Int. location no. 2'
  @sap.quickinfo : 'International location number (Part 2)'
  InternationalLocationNumber2 : String(5);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Check digit'
  @sap.quickinfo : 'Check digit for the international location number'
  InternationalLocationNumber3 : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Natural Person'
  IsNaturalPerson : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Type'
  ResponsibleType : String(2);
  @sap.display.format : 'Date'
  @sap.label : 'QM System Valid To'
  @sap.quickinfo : 'Validity Date of Certification'
  SuplrQltyInProcmtCertfnValidTo : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Actual QM System'
  @sap.quickinfo : 'Supplier''s QM System'
  SuplrQualityManagementSystem : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Group key'
  SupplierCorporateGroup : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Block Function'
  @sap.quickinfo : 'Function That Will Be Blocked'
  SupplierProcurementBlock : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number 1'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  TaxNumber1 : String(16);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number 2'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  TaxNumber2 : String(11);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number 3'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  TaxNumber3 : String(18);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number 4'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  TaxNumber4 : String(18);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number 5'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  TaxNumber5 : String(60);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Number'
  @sap.quickinfo : 'Tax Number at Responsible Tax Authority'
  TaxNumberResponsible : String(18);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax number type'
  @sap.quickinfo : 'Tax Number Type'
  TaxNumberType : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Relevant for POD'
  @sap.quickinfo : 'Supplier indicator relevant for proof of delivery'
  SuplrProofOfDelivRlvtCode : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax split'
  @sap.quickinfo : 'Tax Split'
  BR_TaxIsSplit : Boolean;
  @cds.ambiguous : 'missing on condition?'
  to_SupplierCompany : Association to many API_BUSINESS_PARTNER.A_SupplierCompany {  };
  @cds.ambiguous : 'missing on condition?'
  to_SupplierPurchasingOrg : Association to many API_BUSINESS_PARTNER.A_SupplierPurchasingOrg {  };
  @cds.ambiguous : 'missing on condition?'
  to_SupplierText : Association to many API_BUSINESS_PARTNER.A_SupplierText {  };
};

@cds.persistence.skip : true
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Supplier Company'
entity API_BUSINESS_PARTNER.A_SupplierCompany {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  key Supplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Code'
  key CompanyCode : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.label : 'Company Name'
  @sap.quickinfo : 'Name of Company Code or Company'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CompanyCodeName : String(25);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Payment Block'
  @sap.quickinfo : 'Block Key for Payment'
  PaymentBlockingReason : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Co.code post.block'
  @sap.quickinfo : 'Posting block for company code'
  SupplierIsBlockedForPosting : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Clerk Abbrev.'
  @sap.quickinfo : 'Accounting Clerk Abbreviation'
  AccountingClerk : String(2);
  @sap.label : 'Acctg clerk''s fax'
  @sap.quickinfo : 'Accounting clerk''s fax number at the customer/vendor'
  AccountingClerkFaxNumber : String(31);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Acct.clerks tel.no.'
  @sap.quickinfo : 'Accounting clerk''s telephone number at business partner'
  AccountingClerkPhoneNumber : String(30);
  @sap.label : 'Clerk at vendor'
  SupplierClerk : String(15);
  @sap.label : 'Clrk''s internet add.'
  @sap.quickinfo : 'Internet address of partner company clerk'
  SupplierClerkURL : String(130);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Payment Methods'
  @sap.quickinfo : 'List of Respected Payment Methods'
  PaymentMethodsList : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Payment Terms'
  @sap.quickinfo : 'Terms of Payment Key'
  PaymentTerms : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Clearing with cust.'
  @sap.quickinfo : 'Indicator: Clearing between customer and vendor?'
  ClearCustomerSupplier : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Local Processing'
  @sap.quickinfo : 'Indicator: Local Processing?'
  IsToBeLocallyProcessed : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Individual Payment'
  @sap.quickinfo : 'Indicator: Pay All Items Separately?'
  ItemIsToBePaidSeparately : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Pmnt advice by EDI'
  @sap.quickinfo : 'Indicator: Send Payment Advices by EDI'
  PaymentIsToBeSentByEDI : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'House Bank'
  @sap.quickinfo : 'Short Key for a House Bank'
  HouseBank : String(5);
  @sap.label : 'Check Cashing Time'
  @sap.quickinfo : 'Probable Time Until Check Is Paid'
  CheckPaidDurationInDays : Decimal(3, 0);
  @sap.label : 'Currency'
  @sap.quickinfo : 'Currency Key'
  @sap.semantics : 'currency-code'
  Currency : String(5);
  @sap.unit : 'Currency'
  @sap.label : 'Bill/Ex. Limit'
  @sap.quickinfo : 'Bill of Exchange Limit (in Local Currency)'
  BillOfExchLmtAmtInCoCodeCrcy : Decimal(14, 3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account with vendor'
  @sap.quickinfo : 'Our account number with the vendor'
  SupplierClerkIDBySupplier : String(12);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Reconciliation acct'
  @sap.quickinfo : 'Reconciliation Account in General Ledger'
  ReconciliationAccount : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Interest indicator'
  @sap.quickinfo : 'Interest Indicator'
  InterestCalculationCode : String(2);
  @sap.display.format : 'Date'
  @sap.label : 'Last Key Date'
  @sap.quickinfo : 'Key Date of Last Interest Calculation'
  InterestCalculationDate : Date;
  @sap.display.format : 'NonNegative'
  @sap.label : 'Int.Calc.Freq.'
  @sap.quickinfo : 'Interest Calculation Frequency in Months'
  IntrstCalcFrequencyInMonths : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Head office'
  @sap.quickinfo : 'Head office account number'
  SupplierHeadOffice : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Alternative payee'
  @sap.quickinfo : 'Account number of the alternative payee'
  AlternativePayee : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Sort key'
  @sap.quickinfo : 'Key for sorting according to assignment numbers'
  LayoutSortingRule : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tolerance Group'
  @sap.quickinfo : 'Tolerance Group for Business Partner/G/L Account'
  APARToleranceGroup : String(4);
  @sap.display.format : 'Date'
  @sap.label : 'Certification Date'
  SupplierCertificationDate : Date;
  @sap.label : 'Account Memo'
  @sap.quickinfo : 'Memo'
  SupplierAccountNote : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'WTax C/R Key'
  @sap.quickinfo : 'Withholding Tax Country/Region Key'
  WithholdingTaxCountry : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Co.cde deletion flag'
  @sap.quickinfo : 'Deletion Flag for Master Record (Company Code Level)'
  DeletionIndicator : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Planning Group'
  CashPlanningGroup : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Check Double Invoice'
  @sap.quickinfo : 'Check Flag for Double Invoices or Credit Memos'
  IsToBeCheckedForDuplicates : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Minority Indicator'
  MinorityGroup : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account group'
  @sap.quickinfo : 'Vendor account group'
  SupplierAccountGroup : String(4);
  @cds.ambiguous : 'missing on condition?'
  to_CompanyText : Association to many API_BUSINESS_PARTNER.A_SupplierCompanyText {  };
  @cds.ambiguous : 'missing on condition?'
  to_Supplier : Association to API_BUSINESS_PARTNER.A_Supplier {  };
  @cds.ambiguous : 'missing on condition?'
  to_SupplierDunning : Association to many API_BUSINESS_PARTNER.A_SupplierDunning {  };
  @cds.ambiguous : 'missing on condition?'
  to_SupplierWithHoldingTax : Association to many API_BUSINESS_PARTNER.A_SupplierWithHoldingTax {  };
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Supplier Company Text'
entity API_BUSINESS_PARTNER.A_SupplierCompanyText {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  key Supplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Code'
  key CompanyCode : String(4);
  @sap.label : 'Language'
  @sap.quickinfo : 'Language key'
  key Language : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Text ID'
  key LongTextID : String(4);
  @sap.label : 'String'
  @sap.heading : ''
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  LongText : LargeString;
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Supplier Dunning'
entity API_BUSINESS_PARTNER.A_SupplierDunning {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  key Supplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Code'
  key CompanyCode : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Dunning Area'
  key DunningArea : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Dunning Block'
  DunningBlock : String(1);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Dunning Level'
  DunningLevel : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Dunning Procedure'
  DunningProcedure : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Dunn.recipient'
  @sap.quickinfo : 'Account number of the dunning recipient'
  DunningRecipient : String(10);
  @sap.display.format : 'Date'
  @sap.label : 'Last Dunned'
  @sap.quickinfo : 'Date of Last Dunning Notice'
  LastDunnedOn : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Legal Dunn.Proc.From'
  @sap.quickinfo : 'Date of the Legal Dunning Proceedings'
  LegDunningProcedureOn : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Dunning Clerk'
  DunningClerk : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account group'
  @sap.quickinfo : 'Vendor account group'
  SupplierAccountGroup : String(4);
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Purchasing Partner Functions'
entity API_BUSINESS_PARTNER.A_SupplierPartnerFunc {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  key Supplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Purch. Organization'
  @sap.quickinfo : 'Purchasing Organization'
  key PurchasingOrganization : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier Subrange'
  key SupplierSubrange : String(6);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Plant'
  key Plant : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Partner Function'
  key PartnerFunction : String(2);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Partner counter'
  key PartnerCounter : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Default Partner'
  DefaultPartner : Boolean;
  @sap.display.format : 'Date'
  @sap.label : 'Created On'
  @sap.quickinfo : 'Date on Which Record Was Created'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CreationDate : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Created By'
  @sap.quickinfo : 'Name of Person Responsible for Creating the Object'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  CreatedByUser : String(12);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Ref. to suplr'
  @sap.quickinfo : 'Reference to other supplier'
  ReferenceSupplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
};

@cds.persistence.skip : true
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Purchasing Organization'
entity API_BUSINESS_PARTNER.A_SupplierPurchasingOrg {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Vendor''s account number'
  key Supplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Purch. Organization'
  @sap.quickinfo : 'Purchasing Organization'
  key PurchasingOrganization : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Schema Grp, Supplier'
  @sap.quickinfo : 'Group for Calculation Schema (Supplier)'
  CalculationSchemaGroupCode : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Del. flag POrg.'
  @sap.quickinfo : 'Deletion Indicator for Supplier at Purchasing Level'
  DeletionIndicator : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Incoterms'
  @sap.quickinfo : 'Incoterms (Part 1)'
  IncotermsClassification : String(3);
  @sap.label : 'Incoterms (Part 2)'
  IncotermsTransferLocation : String(28);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Incoterms Version'
  IncotermsVersion : String(4);
  @sap.label : 'Incoterms Location 1'
  IncotermsLocation1 : String(70);
  @sap.label : 'Incoterms Location 2'
  IncotermsLocation2 : String(70);
  @sap.display.format : 'UpperCase'
  @sap.label : 'GR-Based Inv. Verif.'
  @sap.quickinfo : 'Indicator: GR-Based Invoice Verification'
  InvoiceIsGoodsReceiptBased : Boolean;
  @sap.label : 'Planned Deliv. Time'
  @sap.quickinfo : 'Planned Delivery Time in Days'
  MaterialPlannedDeliveryDurn : Decimal(3, 0);
  @sap.unit : 'PurchaseOrderCurrency'
  @sap.label : 'Minimum order value'
  MinimumOrderAmount : Decimal(14, 3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Payment Terms'
  @sap.quickinfo : 'Terms of Payment Key'
  PaymentTerms : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Pricing Date Control'
  @sap.quickinfo : 'Price Determination (Pricing) Date Control'
  PricingDateControl : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Automatic PO'
  @sap.quickinfo : 'Automatic Generation of Purchase Order Allowed'
  PurOrdAutoGenerationIsAllowed : Boolean;
  @sap.label : 'Order currency'
  @sap.quickinfo : 'Purchase order currency'
  @sap.semantics : 'currency-code'
  PurchaseOrderCurrency : String(5);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Purchasing Group'
  PurchasingGroup : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Pur. block POrg'
  @sap.quickinfo : 'Purchasing block at purchasing organization level'
  PurchasingIsBlockedForSupplier : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Shipping Conditions'
  ShippingCondition : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'ABC indicator'
  SupplierABCClassificationCode : String(1);
  @sap.label : 'Telephone'
  @sap.quickinfo : 'Supplier''s Telephone Number'
  SupplierPhoneNumber : String(16);
  @sap.label : 'Salesperson'
  @sap.quickinfo : 'Responsible Salesperson at Supplier''s Office'
  SupplierRespSalesPersonName : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Confirmation Control'
  @sap.quickinfo : 'Confirmation Control Key'
  SupplierConfirmationControlKey : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Acknowledgment Reqd'
  @sap.quickinfo : 'Order Acknowledgment Requirement'
  IsOrderAcknRqd : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account group'
  @sap.quickinfo : 'Vendor account group'
  SupplierAccountGroup : String(4);
  @cds.ambiguous : 'missing on condition?'
  to_PartnerFunction : Association to many API_BUSINESS_PARTNER.A_SupplierPartnerFunc {  };
  @cds.ambiguous : 'missing on condition?'
  to_PurchasingOrgText : Association to many API_BUSINESS_PARTNER.A_SupplierPurchasingOrgText {  };
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Purchasing Organization Text'
entity API_BUSINESS_PARTNER.A_SupplierPurchasingOrgText {
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  key Supplier : String(10);
  key PurchasingOrganization : String(4);
  @sap.label : 'Language'
  @sap.quickinfo : 'Language key'
  key Language : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Text ID'
  key LongTextID : String(4);
  @sap.label : 'String'
  @sap.heading : ''
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  LongText : LargeString;
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Supplier Text'
entity API_BUSINESS_PARTNER.A_SupplierText {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  @sap.creatable : 'false'
  @sap.updatable : 'false'
  key Supplier : String(10);
  @sap.label : 'Language'
  @sap.quickinfo : 'Language key'
  key Language : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Text ID'
  key LongTextID : String(4);
  @sap.label : 'String'
  @sap.heading : ''
  @sap.sortable : 'false'
  @sap.filterable : 'false'
  LongText : LargeString;
};

@cds.persistence.skip : true
@sap.content.version : '1'
@sap.label : 'Company Withholding Tax'
entity API_BUSINESS_PARTNER.A_SupplierWithHoldingTax {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  key Supplier : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Company Code'
  key CompanyCode : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Withholding Tax Type'
  @sap.quickinfo : 'Indicator for Withholding Tax Type'
  key WithholdingTaxType : String(2);
  @sap.display.format : 'Date'
  @sap.label : 'Exemption Start Date'
  @sap.quickinfo : 'Date on Which Exemption Begins'
  ExemptionDateBegin : Date;
  @sap.display.format : 'Date'
  @sap.label : 'Exemption End Date'
  @sap.quickinfo : 'Date on Which Exemption Ends'
  ExemptionDateEnd : Date;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Exemption Reason'
  @sap.quickinfo : 'Reason for Exemption'
  ExemptionReason : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Subject to w/tx'
  @sap.quickinfo : 'Indicator: Subject to Withholding Tax?'
  IsWithholdingTaxSubject : Boolean;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Recipient Type'
  @sap.quickinfo : 'Type of Recipient'
  RecipientType : String(2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Exemption Number'
  @sap.quickinfo : 'Exemption Certificate Number'
  WithholdingTaxCertificate : String(25);
  @sap.display.format : 'UpperCase'
  @sap.label : 'W/Tax Code'
  @sap.quickinfo : 'Withholding Tax Code'
  WithholdingTaxCode : String(2);
  @sap.label : 'Exemption Rate'
  WithholdingTaxExmptPercent : Decimal(5, 2);
  @sap.display.format : 'UpperCase'
  @sap.label : 'W/tax number'
  @sap.quickinfo : 'Withholding tax identification number'
  WithholdingTaxNumber : String(16);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
};

