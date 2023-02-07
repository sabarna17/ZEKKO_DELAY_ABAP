# ZEKKO_DELAY_ABAP
RAP Based Easy application creation for delay recording of the Purchase Orders
## Preface
This is a basic application to log the delay of a PO. This app also covers the execution of the Adobe Form from RAP Process executions.

## Step 1 - Create CDS Table | CDS View | CDS Entite | Projection View
1.	Create CDS table – ZEKKO_DMO. [Script](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/zekko_dmo.abap)
2.	Create custom CDS View for EKKO and LIFNR mappings. [Script](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZCDS_EKKO_DMO.abap). Now execute this DDL View(ZDDL_EKKO_DMO) from SE16n and see the values. Here is another CDS View to calculate the final delivery date from EKET. [ZCDS_EKKO_DELIV_DMO](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZCDS_EKKO_DELIV_DMO.abap)
3.	Right click on the CDS table and click on ‘New Data Definition’. Then Choose the option ‘Define Root View Entity’. Name – ZI_EKKO_DMO. [Script](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZI_EKKO_DMO.abap)
4.	Right click on the CDS View entity and create a corresponding Projection View: ZC_EKKO_DMO. [Script](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZC_EKKO_DMO.abap)

## Step 2 - Metadata Extension | Service Definition | Service Binding

1. Right click on the CDS Entity(ZC_EKKO_DMO) & click on Metadata Extension. Metadata Extension: ZC_EKKO_DMO. [Script](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZC_EKKO_DMO_ME.abap)
2. Right click on CDS Entity(ZI_EKKO_DMO) & click on New Service Definition. Service Definition: ZI_EKKO_DMO_SRV. [Script](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZI_EKKO_DMO_SRV.abap)
3. Right click on Service(ZI_EKKO_DMO_SRV) & click on New Service Binding. 
   Service Binding: ZI_EKKO_DMO_SRV. ![Image](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZI_EKKO_DMO_SRV_BIND.jpg). 
   Once Created click on Publish and navigate to the DelayedPO entityset.

## Step 3 - Behaviour Definitions
This has to be same as the **CDS View Entity** name for **CDS View Entity Behaviour Definition** & **Projection view** name for **Projection view Behaviour Definition**
1. Right click on the CDS View entity(ZI_EKKO_DMO) and create **Behaviour definition**. CDS View Entity Behaviour Definition: [Script](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZI_EKKO_DMO_BD.abap)
2. Right click on the Projection View(ZC_EKKO_DMO) and create **Behaviour definition**. CDS View Entity Behaviour Definition: [Script](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZC_EKKO_DMO_BD.abap)

## Note:
1. In metadata extension, Add additionalBinding to add dependency on the F4 help value on the dependent fields - 'supplier' & 'supplier_name'.
2. Add fields as readonly settings in behaviour definition [ZI_EKKO_DMO](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/edit/main/ZI_EKKO_DMO_BD.abap) as 
    > field( readonly ) OldDeliveryDate;

## Step 4 - Create Behaviour Custon Implementation
1. Do the below changes in the Behaviour of - 
   
   ### ZC_EKKO_DMO
   <-- define behavior for ZC_EKKO_DMO alias DelayedPO
   implementation in class zcl_cekko_del_bd unique
   {
      use create;
      use update;
      use delete;
      action SENDEMAIL result [1] $self;
   } -->

2. Do the below changes in the Behaviour of - 
   ### ZI_EKKO_DMO
