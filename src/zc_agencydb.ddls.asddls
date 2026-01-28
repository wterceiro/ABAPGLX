@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZAGENCYDB'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_AGENCYDB
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_AGENCYDB
  association [1..1] to ZR_AGENCYDB as _BaseEntity on $projection.AGENCYID = _BaseEntity.AGENCYID
{
  key Agencyid,
  Name,
  Address,
  Postalcode,
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
