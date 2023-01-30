# ZEKKO_DELAY_ABAP
RAP Based Easy application creation for delay recording of the Purchase Orders
## Step 1 - Create CDS Table | CDS View | CDS Entite | Projection View
1.	Create CDS table – ZEKKO_DMO. Script: [Click here](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/zekko_dmo.abap)
2.	Create custom CDS View for EKKO and LIFNR mappings. Script: [Click here](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZCDS_EKKO_DMO.abap). Now execute this DDL View(ZDDL_EKKO_DMO) from SE16n and see the values.
3.	Right click on the CDS table and click on ‘New Data Definition’. Then Choose the option ‘Define Root View Entity’. Name – ZI_EKKO_DMO. Script: [Click here](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZI_EKKO_DMO.abap)
4.	Right click on the CDS View entity and create a corresponding Projection View: ZC_EKKO_DMO. Script: [Click here](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZC_EKKO_DMO.abap)

## Step 2 - Metadata Extension | Service Definition | Service Binding

1. Right click on the CDS Entity(ZC_EKKO_DMO) & click on Metadata Extension. Metadata Extension: ZC_EKKO_DMO. Script: [Click here](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZC_EKKO_DMO_ME.abap)
2. Right click on CDS Entity(ZI_EKKO_DMO) & click on New Service Definition. Service Definition: ZI_EKKO_DMO_SRV. Script: [Click here](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZI_EKKO_DMO_SRV.abap)
3. Right click on Service(ZI_EKKO_DMO_SRV) & click on New Service Binding. Service Binding: ZI_EKKO_DMO_SRV. Script: ![Click here](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZI_EKKO_DMO_SRV_BIND.jpg). Once Created click on Publish and navigate to the DelayedPO entityset.
