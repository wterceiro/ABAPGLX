CLASS zxbase64 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
        CLASS-METHODS z_xencode64
            importing   xuser           type string
                        xpassword       type string
             returning value(rv_result) type string.

         CLASS-METHODS get_instance
              RETURNING
                VALUE(ro_instance) TYPE REF TO zxbase64.

  PROTECTED SECTION.
  PRIVATE SECTION.
         CLASS-DATA mo_instance TYPE REF TO zxbase64.
            DATA mv_bp TYPE string.

ENDCLASS.



CLASS ZXBASE64 IMPLEMENTATION.


  METHOD get_instance.
    IF mo_instance IS NOT BOUND.
      mo_instance = NEW zxbase64( ).
    ENDIF.
    ro_instance = mo_instance.
  ENDMETHOD.


  METHOD z_xencode64.

     data:
      lo_authorization              type string,
      lo_authorization64            type string,
      xerror                        type string.

      concatenate xuser  ':'  xpassword into lo_authorization.

      try.
        lo_authorization64 = CL_WEB_HTTP_UTILITY=>DECODE_X_BASE64( lo_authorization ).
        rv_result = lo_authorization64.
      catch CX_SY_CONVERSION_NO_NUMBER.
                 rv_result = 'FFFF'.
      endtry.

      return rv_result.

  ENDMETHOD.
ENDCLASS.
