CLASS lhc_DelayedPO DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    CONSTANTS:
      BEGIN OF send_email,
        send_yes TYPE c LENGTH 1  VALUE 'X', " Open
        send_no  TYPE c LENGTH 1  VALUE '', " Accepted
      END OF send_email.
    TYPES: tt_ekko_dmo TYPE TABLE OF zi_ekko_dmo.
    METHODS sendemail FOR MODIFY
      IMPORTING keys FOR ACTION DelayedPO~sendemail RESULT result.
    METHODS send_pdf_email
      IMPORTING it_zi_ekko_dmo TYPE tt_ekko_dmo
      EXPORTING ev_spoolid TYPE RSPOID.

ENDCLASS.

CLASS lhc_DelayedPO IMPLEMENTATION.

  METHOD sendemail.
    " Fill the response table
    READ ENTITIES OF zi_ekko_dmo "IN LOCAL MODE
      ENTITY DelayedPO
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(semdemail).

    result = VALUE #( FOR line IN semdemail
                        ( %tky   = line-%tky
                          %param = line ) ).

    CALL METHOD send_pdf_email
      EXPORTING
        it_zi_ekko_dmo = semdemail
      IMPORTING
        ev_spoolid = DATA(lv_spoolid).
    "
    DATA: lv_splid TYPE c LENGTH 10.
          lv_splid = lv_spoolid.
    DATA(lv_status) = 'New Spool Status: ' && lv_splid.
    " Set the new overall status
    MODIFY ENTITIES OF zi_ekko_dmo "IN LOCAL MODE
      ENTITY DelayedPO
         UPDATE
           FIELDS ( Sendemailstatus )
           WITH VALUE #( FOR key IN keys
                           ( Ebeln         = key-Ebeln
                             ChngUuid      = key-ChngUuid
                             Sendemailstatus = lv_status ) ).

  ENDMETHOD.

  METHOD send_pdf_email.
    DATA: ls_outputparams   TYPE sfpoutputparams,
          lv_fm_name        TYPE rs38l_fnam,      " Function Name
          lv_interface_type TYPE fpinterfacetype,
          ls_formoutput     TYPE fpformoutput,
          ls_sfpdocparams   TYPE sfpdocparams. " interface name.

*ls_outputparams-nodialog = abap_true.
    ls_outputparams-device   = 'PRINTER'.
*ls_outputparams-getpdf   = abap_true.
    ls_outputparams-dest     = 'LP01'.
    ls_outputparams-reqnew   = abap_true. "New spool request
    ls_outputparams-reqimm   = abap_true. "Print immediately
    ls_outputparams-dataset = 'PBFORM'.
    ls_outputparams-reqimm   = abap_true.
    ls_outputparams-suffix2 = sy-uname.
    ls_outputparams-lifetime = 8.
    ls_outputparams-copies = 1.
*ls_outputparams-CONNECTION = 'ADS'.
*ls_outputparams-getpdf = 'X'.
    ls_outputparams-nodialog = 'X'.

*ls_outputparams-dest = 'PDF1'.
*ls_outputparams-ARCMODE = '3'.

    DATA(ls_ekko_dmo) = VALUE #( it_zi_ekko_dmo[ 1 ] OPTIONAL ).

* open form
    CALL FUNCTION 'FP_JOB_OPEN'
      CHANGING
        ie_outputparams = ls_outputparams
      EXCEPTIONS
        cancel          = 1
        usage_error     = 2
        system_error    = 3
        internal_error  = 4
        OTHERS          = 5.
    IF sy-subrc <> 0.
*    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

* Function to find the FM name.
    CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
      EXPORTING
        i_name           = 'ZAF_TEST_PO_DEL_DELAY'
      IMPORTING
        e_funcname       = lv_fm_name
        e_interface_type = lv_interface_type.

    ls_sfpdocparams-langu   = 'EN'.
    ls_sfpdocparams-dynamic = abap_true.
*    DATA(lv_date) = ls_ekko_dmo-DelivDate+6(2) && '.' && ls_ekko_dmo-DelivDate+4(2) && '.' && ls_ekko_dmo-DelivDate+0(4).
    CALL FUNCTION lv_fm_name
      EXPORTING
        /1bcdwb/docparams  = ls_sfpdocparams
        iv_name            = 'Sabarna Chatterjee'
        iv_comment         = ls_ekko_dmo-Comments
        iv_po              = ls_ekko_dmo-Ebeln
        iv_date            = ls_ekko_dmo-DelivDate
*       IV_DELIVERY        =
      IMPORTING
        /1bcdwb/formoutput = ls_formoutput
      EXCEPTIONS
        usage_error        = 1
        system_error       = 2
        internal_error     = 3
        OTHERS             = 4.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
    DATA: ls_SFPJOBOUTPUT TYPE  sfpjoboutput.
    CALL FUNCTION 'FP_JOB_CLOSE'
      IMPORTING
        e_result       = ls_SFPJOBOUTPUT
      EXCEPTIONS
        usage_error    = 1
        system_error   = 2
        internal_error = 3
        OTHERS         = 4.
    IF sy-subrc = 0.
      DATA(lt_spid) = ls_SFPJOBOUTPUT-spoolids[].
      READ TABLE lt_spid INTO DATA(wa_spid) INDEX 1 .
      DATA(wa_spoolid) = wa_spid.
      IF wa_spoolid > 0.
        CALL FUNCTION 'RSPO_OUTPUT_SPOOL_REQUEST'
          EXPORTING
            device           = 'LP01'
            spool_request_id = wa_spoolid.
        ev_spoolid = wa_spoolid.
      ENDIF.
* Implement suitable error handling here
    ENDIF.
  ENDMETHOD.
ENDCLASS.
