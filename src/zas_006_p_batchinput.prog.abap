*&---------------------------------------------------------------------*
*& Report ZAS_006_P_BATCHINPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAS_006_P_BATCHINPUT.

PARAMETERS p_maktx TYPE maktx.
DATA: lt_bdcdata TYPE TABLE OF bdcdata,
      ls_bdcdata TYPE  bdcdata,
      lt_messtab TYPE TABLE OF bdcmsgcoll,
      ls_messtab TYPE  bdcmsgcoll.

START-OF-SELECTION.

  PERFORM bdc_dynpro      USING 'SAPLMGMM' '0060'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'RMMG1-MTART'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=ENTR'.
  PERFORM bdc_field       USING 'RMMG1-MBRSH'
                                'A'.
  PERFORM bdc_field       USING 'RMMG1-MTART'
                                'MMPC'.
  PERFORM bdc_dynpro      USING 'SAPLMGMM' '0070'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'MSICHTAUSW-DYTXT(01)'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=ENTR'.
  PERFORM bdc_field       USING 'MSICHTAUSW-KZSEL(01)'
                                'X'.
  PERFORM bdc_dynpro      USING 'SAPLMGMM' '4004'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '/00'.
  PERFORM bdc_field       USING 'MAKT-MAKTX'
                                 p_maktx.
  PERFORM bdc_field       USING 'MARA-MEINS'
                                'ADT'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'MARA-GEWEI'.
  PERFORM bdc_field       USING 'MARA-BRGEW'
                               '6'.
  PERFORM bdc_field       USING 'MARA-GEWEI'
                                'KG'.
  PERFORM bdc_field       USING 'MARA-NTGEW'
                                '3'.
  PERFORM bdc_dynpro      USING 'SAPLSPO1' '0300'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=YES'.
*perform bdc_transaction using 'MM01'.
  CALL TRANSACTION 'MM01' WITH AUTHORITY-CHECK USING lT_bdcdata
                   MODE   'A'
*                   UPDATE cupdate
                   MESSAGES INTO lt_messtab.

FORM bdc_dynpro USING program dynpro.
  CLEAR ls_bdcdata.
  ls_bdcdata-program  = program.
  ls_bdcdata-dynpro   = dynpro.
  ls_bdcdata-dynbegin = 'X'.
  APPEND ls_bdcdata TO lT_bdcdata .
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.

    CLEAR ls_bdcdata.
    ls_bdcdata-fnam = fnam.
    ls_bdcdata-fval = fval.
    APPEND ls_bdcdata TO lT_bdcdata .

ENDFORM.
