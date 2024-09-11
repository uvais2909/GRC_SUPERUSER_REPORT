*&---------------------------------------------------------------------*
*&  Include           ZZLCL_CLASS
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS get_data.

  PROTECTED SECTION.
    METHODS display.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD get_data.
    IF p_user IS NOT INITIAL.
      "You can use BAPI_USER_GET_DETAIL to fetch profiles as well
      SELECT a~bname,
             a~gltgv,
             a~gltgb,
             a~ustyp,
             b~profile
        FROM usr02 AS a INNER JOIN ust04 AS b
        ON a~bname = b~bname
        WHERE a~bname = @p_user
        INTO TABLE @lt_main.

      IF sy-subrc EQ 0.
        "User exists
        READ TABLE lt_main WITH KEY profile = 'SAP_ALL' TRANSPORTING NO FIELDS.
        IF sy-subrc EQ 0.
          DATA(lv_flg1) = 'X'.
        ENDIF.

        READ TABLE lt_main WITH KEY profile = 'SAP_NEW' TRANSPORTING NO FIELDS.
        IF sy-subrc EQ 0.
          DATA(lv_flg2) = 'X'.
        ENDIF.

        IF lv_flg1 IS INITIAL AND lv_flg2 IS INITIAL.
          MESSAGE p_user && ' does not have superuser access' TYPE 'I'.
        ELSE.
          MESSAGE p_user && ' has superuser access' TYPE 'I'.
          display( ).
        ENDIF.

      ELSE.
        "User does not exist
        MESSAGE p_user && ' does not exist.' TYPE 'E' DISPLAY LIKE 'I'.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD display.
    DATA lo_msg TYPE REF TO cx_salv_msg.
    "Display ALV
    TRY.
        cl_salv_table=>factory(
        IMPORTING
          r_salv_table   = lo_alv                          " Basis Class Simple ALV Tables
        CHANGING
          t_table        = lt_main ).
        CATCH cx_salv_msg INTO lo_msg.

    ENDTRY.

      lo_fun = lo_alv->get_functions( ).
      lo_fun->set_all( ).
      lo_alv->display( ).
    ENDMETHOD.
ENDCLASS.
