managed;

define behavior for ZI_EKKO_DMO alias DelayedPO
persistent table zekko_dmo
lock master
{
  create;
  update;
  delete;

  field( numbering: managed, readonly ) ChngUuid;
  field( readonly ) OldDeliveryDate;
  field( readonly ) supplier_name;
  field( readonly ) supplier;
  field( readonly ) ActionBy;

  mapping for zekko_dmo
  {
    ChngUuid   = chng_uuid;
    Ebeln      = ebeln;
    DelivDate  = deliv_date;
    ActionBy   = action_by;
    ActionTs   = action_ts;
    Comments   = comments;
  }
}
