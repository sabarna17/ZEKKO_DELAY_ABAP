CLASS zcl_ekko_del DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_ekko_del IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    READ ENTITIES OF zi_ekko_dmo
    ENTITY DelayedPO
    ALL FIELDS
    WITH VALUE #( ( ChngUuid  = '13D09EB0F2BC1EEDA8A41F9DFF41888A' Ebeln = '1083363076') )
    RESULT DATA(output)
    FAILED DATA(failed)
    REPORTED DATA(reported).
    out->write( output ).
  ENDMETHOD.
ENDCLASS.
