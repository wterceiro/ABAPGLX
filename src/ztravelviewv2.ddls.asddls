@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel test View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZTRAVELViewV2 as select from ztraveldb

  association of exact one to exact one ZAGENCYVIEW 
    as _Agency
    on $projection.Agencyid = _Agency.Agencyid


{
    key travelid as Travelid,
    agencyid as Agencyid,
    begindate as Begindate,
    enddate as Enddate,
    waers as Waers,
@Semantics.amount.currencyCode: 'Waers'
    price as Price,
    _Agency.Name as AgName,
    _Agency.Address as AdAddress,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
}
