@EndUserText.label : 'Ekko dmo'
@AbapCatalog.enhancement.category : #EXTENSIBLE_ANY
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #ALLOWED
define table zekko_dmo {
  key client    : abap.clnt not null;
  key chng_uuid : sysuuid_x16 not null;
  key ebeln     : ebeln not null;
  deliv_date    : abap.datn;
  action_by     : syuname;
  action_ts     : timestampl;
  comments      : abap.char(100);

}
