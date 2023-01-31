@AbapCatalog.sqlViewName: 'ZDDL_EKKO_DMO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor Details of PO'
define view ZCDS_EKKO_DMO as select distinct from ekko inner join lfa1 on lfa1.lifnr = ekko.lifnr 
{
 key ekko.ebeln,
 lfa1.lifnr as supplier,
 cast( concat_with_space(lfa1.name1,lfa1.name2, 1) as bapi_jbd_dte_xallb ) as supplier_name    
}
