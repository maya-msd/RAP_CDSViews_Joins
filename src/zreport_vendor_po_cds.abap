*&---------------------------------------------------------------------*
*& Report zreport_vendor_po_cds
*& Consuming Parameterized Multi-Table CDS View via ABAP SQL
*&---------------------------------------------------------------------*
REPORT zreport_vendor_po_cds.

DATA: lv_ebeln TYPE ekko-ebeln.

SELECT-OPTIONS: s_ebeln FOR lv_ebeln.

START-OF-SELECTION.

  " Select from parameterized CDS view passing low/high boundary parameters
  SELECT *
    FROM zbtp_vendor_cds(
           po_l = @s_ebeln-low,
           po_h = @s_ebeln-high
         )
    INTO TABLE @DATA(it_final).

  IF it_final IS NOT INITIAL.
    SORT it_final BY ebeln ASCENDING.
    cl_demo_output=>display( it_final ).
  ELSE.
    MESSAGE 'No Data Found for the specified PO range.' TYPE 'I'.
  ENDIF.
