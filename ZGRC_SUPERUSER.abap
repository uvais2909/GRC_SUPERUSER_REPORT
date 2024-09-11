*&---------------------------------------------------------------------*
*& Report ZGRC_SUPERUSER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGRC_SUPERUSER.

INCLUDE: zzdata_dec,      "Data Declaration 
         zzsel_screen,    "Selection Screen
         zzlcl_class.     "Local classes


START-OF-SELECTION.
  DATA(lo_obj) = NEW lcl_main( ).
  lo_obj->get_data( ).
