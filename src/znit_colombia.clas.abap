CLASS znit_colombia DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO znit_colombia.

    METHODS set_bp
      IMPORTING
        iv_bp TYPE string.

    METHODS get_bp
      RETURNING VALUE(rv_bp) TYPE string.


  PROTECTED SECTION.
  PRIVATE SECTION.
      CLASS-DATA mo_instance TYPE REF TO znit_colombia.
    DATA mv_bp TYPE string.

ENDCLASS.



CLASS znit_colombia IMPLEMENTATION.

  METHOD get_bp.
    rv_bp = mv_bp.
  ENDMETHOD.


  METHOD get_instance.
    IF mo_instance IS NOT BOUND.
      mo_instance = NEW znit_colombia( ).

    ENDIF.

    ro_instance = mo_instance.
  ENDMETHOD.


  METHOD set_bp.
    mv_bp = iv_bp.
  ENDMETHOD.


ENDCLASS.
