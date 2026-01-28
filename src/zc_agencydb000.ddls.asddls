@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZAGENCYDB'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_AGENCYDB000
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_AGENCYDB
  association [1..1] to ZR_AGENCYDB as _BaseEntity on $projection.AGENCYID = _BaseEntity.AGENCYID
{
  key Agencyid,
  Name,
  Address,
  Postalcode,
  @Endusertext: {
    Label: 'Created By', 
    Quickinfo: 'Created By User'
  }
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Endusertext: {
    Label: 'Created On', 
    Quickinfo: 'Creation Date Time'
  }
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Endusertext: {
    Label: 'Changed By', 
    Quickinfo: 'Last Changed By User'
  }
  @Semantics: {
    User.Lastchangedby: true
  }
  LastChangedBy,
  @Endusertext: {
    Label: 'Changed On', 
    Quickinfo: 'Last Change Date Time'
  }
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  @Endusertext: {
    Label: 'Changed On', 
    Quickinfo: 'Local Instance Last Change Date Time'
  }
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
