@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZTRAVELDB'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_TRAVELDB
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_TRAVELDB
  association [1..1] to ZR_TRAVELDB as _BaseEntity on $projection.TRAVELID = _BaseEntity.TRAVELID
{
  key Travelid,
  Agencyid,
  Begindate,
  Enddate,
  @Semantics: {
    Amount.Currencycode: 'Waers'
  }
  Price,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  Waers,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Semantics: {
    User.Lastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
