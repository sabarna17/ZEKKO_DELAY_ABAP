projection;
//strict; //Comment this line in to enable strict mode. The strict mode is prerequisite to be future proof regarding syntax and to be able to release your BO.

define behavior for ZC_EKKO_DMO alias DelayedPO
{
  use create;
  use update;
  use delete;
}
