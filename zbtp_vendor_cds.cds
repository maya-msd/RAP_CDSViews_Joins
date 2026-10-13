@AbapCatalog.sqlViewName: 'ZV_VEND_PO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor and Purchase Order Analytics View'

define view ZBTP_VENDOR_CDS
  with parameters
    PO_L : ebeln,
    PO_H : ebeln
  as select from    lfa1 as L
    inner join      ekko as E on L.lifnr = E.lifnr
    inner join      ekpo as P on E.ebeln = P.ebeln
{
  key L.lifnr,
      L.name1,
      L.ort01,
      L.land1,
      E.ebeln,
      E.bukrs,
      E.aedat,
      E.statu,
      P.ebelp,
      P.matnr,
      P.meins
}
where
  E.ebeln between $parameters.PO_L and $parameters.PO_H;
