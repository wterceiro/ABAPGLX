@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel test View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZTRAVELView as select from ztraveldb
{
    key travelid as Travelid,
    agencyid as Agencyid,
    begindate as Begindate,
    enddate as Enddate,
    waers as Waers,
@Semantics.amount.currencyCode: 'Waers'
    price as Price

}
