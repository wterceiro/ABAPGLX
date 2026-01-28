CLASS z_abap_call_postjourna_fi DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS post_journal_entry
      IMPORTING
        iv_company_code TYPE char4
        iv_posting_date TYPE char10
        iv_debit_amount TYPE char15
        iv_credit_amount TYPE char15
      RAISING
        cx_ai_system_fault .

ENDCLASS.



CLASS Z_ABAP_CALL_POSTJOURNA_FI IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.
    TRY.
        post_journal_entry(
          iv_company_code = '1410' " Example Company Code
          iv_posting_date = '2025-11-11'
          iv_debit_amount = '100.00'
          iv_credit_amount = '100.00'
        ).
        out->write( 'Journal Entry Post successful.' ).
      CATCH cx_ai_system_fault INTO DATA(lx_error).
        out->write( |Error during SOAP call: { lx_error->get_text( ) }| ).
    ENDTRY.
  ENDMETHOD.


METHOD post_journal_entry.

              data:
              ls_desirialize TYPE zcjournal_entry_create_reque19,
              ls_je          TYPE zcjournal_entry_bulk_create_re,
              lr_cscn        TYPE if_com_scenario_factory=>ty_query-cscn_id_range,
              lo_factory     TYPE REF TO if_com_arrangement_factory,
              lv_host        TYPE string,
              lx_hostname    TYPE string value 'https://my4101595-api.lab.s4hana.cloud.sap:443',
              c_password     type string,
              c_doc_text     type string,
              lo_sys_exception TYPE REF TO cx_ai_system_fault.

              c_password = 'i-@LJ4G2nZ(YNH>m2qf\CccBh+yex3h%=+D/8B[T'.
              DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
              CONSTANTS c_scenario_id  TYPE string VALUE 'SAP_COM_0002'.
              CONSTANTS c_path_je      TYPE string VALUE '/sap/bc/srt/scs_ext/sap/journalentrycreaterequestconfi'.

              concatenate 'Test ABAP Pos' ' Company Code 1410' into c_doc_text.

              concatenate lx_hostname c_path_je into lv_host.

              DATA(destinationx) = cl_soap_destination_provider=>create_by_url( lv_host ).
              destinationx->set_basic_authentication( i_user     = 'MY4101595_USER'
                                                           i_password = c_password ).

              data(lo_proxy) = new zcco_journal_entry_create_requ( destination = destinationx ).


              data(ls_request) = value zcjournal_entry_bulk_create_re( journal_entry_bulk_create_requ
                            = value #( journal_entry_create_request
                            = value #( (  journal_entry
                            = value #(
                                       original_reference_document_ty = 'BKPFF'
                                       business_transaction_type      = 'RFIC'
                                       accounting_document_type       = 'DR'
                                       document_reference_id          = '123'
                                       document_header_text           = c_doc_text
                                       created_by_user                = sy-uname
                                       company_code                   = '1410'
                                       document_date                  = lv_date
                                       posting_date                   = lv_date
                                       item
                                       = value #(
                                                 (  document_item_text =   'Item 01'
                                                    reference_document_item        = '1'
                                                    glaccount-content              = '0041000000'
                                                    amount_in_transaction_currency = VALUE #( content       = -1000
                                                                                     currency_code = 'BRL' )
                                                   amount_in_company_code_currenc = VALUE #( content       = -1000
                                                                                     currency_code = 'BRL' )
                                                   debit_credit_code              = 'H'
                                                   profitability_supplement = value #( customer = '14100001' )
                                                   account_assignment = value #( profit_center = 'YB700' )
                                                  )
                                         )
                                        debtor_item
                                        = value #(
                                                ( reference_document_item = '2'
                                                   debtor = '14100001'
                                                    amount_in_transaction_currency = value #(
                                                                                                         currency_code = 'BRL'
                                                                                                         content = 1000 )
                                                    debit_credit_code = 'S'
                                                    document_item_text = 'Customer 1'
                                                )
                                        )
                                     )
                                     )
                                     )
                                     ) ).






" 3. Call the synchronous service method
    lo_proxy->journal_entry_create_request_c(
      exporting
        input = ls_request
      importing
        output = data(response)
    ).





ENDMETHOD.





ENDCLASS.
