@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Base CDS View Entity'
define root view entity ZI_EKKO_DMO 
 as select distinct from zekko_dmo as ekko_dmo
 
 association [0..1] to ZCDS_EKKO_DMO as _ekko on $projection.Ebeln = _ekko.ebeln
// association [0..1] to lfa1 as _lfa1 on _lfa1.lifnr = _ekko.lifnr
  
{
    key chng_uuid as ChngUuid,
    key ebeln as Ebeln,
    cast( '20230423' as abap.dats ) as OldDeliveryDate, 
    deliv_date as DelivDate,
    _ekko.supplier,
    @UI.connectedFields: [{ label: 'Supplier Name' }]
    _ekko.supplier_name, 
    @Semantics.user.lastChangedBy: true
    action_by as ActionBy,
    @Semantics.systemDateTime.lastChangedAt: true
    action_ts as ActionTs,
    comments as Comments
}
