*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lhc_DelayedPO DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS MODIFY FOR behavior
    Importing it_send_email FOR ACTION DelayedPO~SENDEMAIL RESULT result.
ENDCLASS.

CLASS lhc_DelayedPO IMPLEMENTATION.
  METHOD MODIFY.
    " Set the new overall status
  ENDMETHOD.
ENDCLASS.
