# RAP_CDSViews_Joins
A CDS view created using joining two tables: EKKO and EKPO
# SAP S/4HANA MM & ABAP: Multi-Table CDS Joins with Parameterized Range Filtering

Core Data Services (CDS) data model combining Vendor Master and Procurement Purchasing documents (`LFA1`, `EKKO`, `EKPO`) using inner joins and range filtering parameters, consumed via modern ABAP Open SQL.

## Architecture & Data Flow

### 1. Data Modeling (`zbtp_vendor_cds.asddls`)
* **Relational Joins**:
  * `LFA1` (Vendor Master General Data)
  * `EKKO` (Purchasing Document Header) joined on `lifnr`
  * `EKPO` (Purchasing Document Item) joined on `ebeln`
* **Input Parameters**:
  * `PO_L` (`ebeln`): Lower boundary purchase order number.
  * `PO_H` (`ebeln`): Upper boundary purchase order number.
* **In-Database Filtering**:
  * Evaluates purchase order boundaries at the SAP HANA database layer using `between $parameters.PO_L and $parameters.PO_H`.

### 2. ABAP Consumer Program (`zreport_vendor_po_cds.abap`)
* Maps user input from ABAP `SELECT-OPTIONS` (`s_ebeln-low`, `s_ebeln-high`) directly into the CDS view parameter signature.
* Uses inline host variable expressions (`@DATA(it_final)`).
* Sorts the resulting dataset by `ebeln` and displays the output via `cl_demo_output`.

## Technologies Used
* SAP Core Data Services (CDS)
* SAP S/4HANA Sourcing & Procurement Data Model (`LFA1`, `EKKO`, `EKPO`)
* Modern ABAP SQL (Inline Declarations & Parameter Binding)
* Eclipse ADT
