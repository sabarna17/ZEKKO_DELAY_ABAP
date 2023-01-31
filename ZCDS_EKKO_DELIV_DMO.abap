@AbapCatalog.sqlViewName: 'ZDDL_EKKO_DELIV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery Date for PUR ORD'
define view ZCDS_EKKO_DELIV_DMO 
as select from eket {
    key ebeln,
    max(eindt) as final_del
}
group by ebeln
