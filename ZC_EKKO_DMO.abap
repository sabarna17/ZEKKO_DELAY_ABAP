@EndUserText.label: 'Projection view on EKKO'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_EKKO_DMO as projection on ZI_EKKO_DMO
{
    key ChngUuid,
    @Search.defaultSearchElement: true
    key Ebeln,
    ZI_EKKO_DMO.supplier as supplier,
    OldDeliveryDate,
    @Search.defaultSearchElement: true
    supplier_name,
    DelivDate,
    ActionBy,
    ActionTs,
    Comments
}
