*&---------------------------------------------------------------------*
*&  Include           ZZDATA_DEC
*&---------------------------------------------------------------------*

TYPES: BEGIN OF ty_main,
         bname   TYPE xubname,
         gltgv   TYPE xugltgv,
         gltgb   TYPE xugltgb,
         ustyp   TYPE xuustyp,
         profile TYPE xuprofile,
       END OF ty_main.

"ALV
 DATA: lo_alv TYPE REF TO cl_salv_table,
       lo_fun TYPE REF TO cl_salv_functions_list,
"Internal Table
       lt_main TYPE STANDARD TABLE OF ty_main.
