**********************************************************************
* William Terceiro
* como chamar essa Classe dentro do Custom logic :
******** Definir um data como :
* DATA(fi_buffer) = z_abap_call_postjournalentry=>get_instance( ).
* data xretorno type string.
* data xnumdoc  type string.
******      Obter um numero documento :
*     xnumdoc = accountingdocheader-accountingdocument.
*
******   Verificar o cliente e se tipo documento Venda
*
*    IF  accountingdocitem-customer = '0014100001' and  accountingdocheader-accountingdocumenttype = 'RV'.
*
******    Chamar o metodo create_je passando o numero do documento para a o parametro lt_numdoc da classe e obter o retorno
*       xretorno =  fi_buffer->create_je( lt_numdoc = xnumdoc ).
*
*       CL_BLE_TRACE_WRITER=>write_info_message( message = |passou pelo teste : { xretorno } | ).
*              substitutiondone = abap_true.
*
*    endif.*

CLASS z_abap_call_postjournalentry DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
*        interfaces if_oo_adt_classrun.

     CLASS-METHODS: create_je
            importing lt_numdoc type string
            Returning
            value(ro_retorno) type string.


    CLASS-METHODS get_instance
              RETURNING
                VALUE(ro_instance) TYPE REF TO z_abap_call_postjournalentry.


  PROTECTED SECTION.
    PRIVATE SECTION.
         CLASS-DATA mo_instance TYPE REF TO z_abap_call_postjournalentry.
            DATA mv_bp TYPE string.
ENDCLASS.



CLASS Z_ABAP_CALL_POSTJOURNALENTRY IMPLEMENTATION.


  METHOD create_je.

         try.


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

          DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
          CONSTANTS c_scenario_id  TYPE string VALUE 'SAP_COM_0002'.
          CONSTANTS c_path_je      TYPE string VALUE '/sap/bc/srt/scs_ext/sap/journalentrycreaterequestconfi'.

          concatenate 'Test ABAP Reverse Doc=' lt_numdoc into c_doc_text.

          concatenate lx_hostname c_path_je into lv_host.

         DATA(ls_request) = VALUE zcjournal_entry_bulk_create_re(
                              journal_entry_bulk_create_requ
                            = VALUE #(
                               journal_entry_create_request = value #(
                               ( journal_entry = value #(
                                              original_reference_document_ty = 'BKPFF'
                                              original_reference_document    = '2002'
                                              business_transaction_type      = 'RFBU'
                                              accounting_document_type       = 'SA'
                                              document_reference_id          = '123'
                                              document_header_text           = c_doc_text
                                              created_by_user                = sy-uname
                                              company_code                   = '1410'
                                              document_date                  = lv_date
                                              posting_date                   = lv_date
                                              item = VALUE #(
                                                  document_item_text =   'Item 01'
                                                  ( reference_document_item        = '1'
                                                    glaccount-content              = '0065301000'
                                                    amount_in_transaction_currency = VALUE #( content       = 2000
                                                                                              currency_code = 'BRL' )
                                                    amount_in_company_code_currenc = VALUE #( content       = 2000
                                                                                              currency_code = 'BRL' )
                                                    debit_credit_code              = 'S'
                                                    tax                            = VALUE #( tax_code-content = '00'
                                                                                              tax_item_group   = '1' )
                                                    account_assignment-cost_center = '14101601' )

                                                  ( reference_document_item        = '2'
                                                    glaccount-content              = '0029110000'
                                                    amount_in_transaction_currency = VALUE #( content       = -2000
                                                                                              currency_code = 'BRL' )
                                                    account_assignment-cost_center = '14101601'
                                                    debit_credit_code              = 'H' ) )
                                               product_tax_item               = VALUE #(
                                                  ( tax_code-content               = '00'
                                                    tax_item_group                 = '1'
                                                    reference_document_item        = '1'
                                                    amount_in_transaction_currency = VALUE #( content       = -100
                                                                                              currency_code = 'BRL' )
                                                    tax_base_amount_in_trans_crcy  = VALUE #( content       = -100
                                                                                              currency_code = 'BRL' )
                                                    tax_item_classification        = 'ISW'
                                                    tax_jurisdiction-content       = 'SP 3550308'
                                                    debit_credit_code              = 'H'
                                                    is_direct_tax_posting          = 'X' ) )

                                                )
                                                     message_header = VALUE #(
                                                        creation_date_time = |{ cl_abap_context_info=>get_system_date( ) }T{ cl_abap_context_info=>get_system_time( ) }Z|
                                                        sender_business_system_id = 'SENDER_SYS' " Your sending system ID
                                                        )
                                )
                    )
                )
            ).



*                    lr_cscn = VALUE #( ( sign = 'I' option = 'EQ' low = c_scenario_id ) ).
*                    lo_factory = cl_com_arrangement_factory=>create_instance( ).
*                    lo_factory->query_ca( EXPORTING is_query           = VALUE #( cscn_id_range = lr_cscn )
*                                          IMPORTING et_com_arrangement = DATA(lt_comm_arrang) ).
*
*                    READ TABLE lt_comm_arrang INTO DATA(lo_comm_arrang) INDEX 1.

                    c_password = 'i-@LJ4G2nZ(YNH>m2qf\CccBh+yex3h%=+D/8B[T'.

                    DATA(destinationx) = cl_soap_destination_provider=>create_by_url( lv_host ).
                    destinationx->set_basic_authentication( i_user     = 'MY4101595_USER'
                                                           i_password = c_password ).

                data(proxy) = new zcco_journal_entry_create_requ( destination = destinationx ).

                " fill request
                data(request) = value zcjournal_entry_bulk_create_re( journal_entry_bulk_create_requ = ls_desirialize ).

                proxy->journal_entry_create_request_c(
                  exporting
                    input = request
                  importing
                    output = data(response)
                ).

                ro_retorno = 'Post ok com sucesso'.

                return ro_retorno.


                " handle response
              catch cx_soap_destination_error.
                        ro_retorno = 'Erro SOAP Destination'.
              catch cx_ai_system_fault INTO lo_sys_exception.
                    DATA(lv_error) = lo_sys_exception->get_longtext( ).
                    ro_retorno = 'Erro AI_System exception'.
            endtry.




     ENDMETHOD.


  METHOD get_instance.
    IF mo_instance IS NOT BOUND.
       mo_instance = NEW z_abap_call_postjournalentry( ).
    ENDIF.
    ro_instance = mo_instance.
  ENDMETHOD.

ENDCLASS.
