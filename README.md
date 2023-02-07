# ZEKKO_DELAY_ABAP
RAP Based Easy application creation for delay recording of the Purchase Orders
## Preface
This is a basic application to log the delay of a PO. This app also covers the execution of the Adobe Form from RAP Process executions.

## Step 1 - Create CDS Table | CDS View | CDS Entity | Projection View
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

## Step 3 - Behavior Definitions
This has to be same as the **CDS View Entity** name for **CDS View Entity Behaviour Definition** & **Projection view** name for **Projection view Behaviour Definition**
1. Right click on the CDS View entity(ZI_EKKO_DMO) and create **Behaviour definition**. CDS View Entity Behaviour Definition: [Script](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZI_EKKO_DMO_BD.abap)
2. Right click on the Projection View(ZC_EKKO_DMO) and create **Behaviour definition**. CDS View Entity Behaviour Definition: [Script](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/ZC_EKKO_DMO_BD.abap)


## Note:
1. In metadata extension, Add additionalBinding to add dependency on the F4 help value on the dependent fields - 'supplier' & 'supplier_name'.
2. Add fields as readonly settings in behaviour definition [ZI_EKKO_DMO](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/edit/main/ZI_EKKO_DMO_BD.abap) as 
    > field( readonly ) OldDeliveryDate;
3. Create the behaviour definitions with the same name as - the CDS View Entity and Projection view name

## Step 4 - Test Read operations:
   Create a simple class as below to read the Table data: [zcl_ekko_del](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/zcl_ekko_del.abap)

## Step 5 - Create Behavior Custom Implementation
1. Do the below changes in the Behaviour of - 
   
   ### ZC_EKKO_DMO
   ``` 
   projection;
   define behavior for ZC_EKKO_DMO alias DelayedPO
   implementation in class zcl_cekko_del_bd unique
   {
      use create;
      use update;
      use delete;
      action SENDEMAIL result [1] $self;
   } 
   ```

2. Do the below changes in the Behaviour of - 
   ### ZI_EKKO_DMO
   ```
   managed;
   define behavior for ZI_EKKO_DMO alias DelayedPO
   implementation in class zcl_ekko_del_bd unique
   persistent table zekko_dmo
   lock master
   {  
      create;
      update;
      delete;
      action SENDEMAIL result [1] $self;
   
      field( numbering: managed, readonly ) ChngUuid;
      field( readonly ) OldDeliveryDate;
      field( readonly ) supplier_name;
      field( readonly ) supplier;
      field( readonly ) ActionBy;
      mapping for zekko_dmo
      {
         ChngUuid   = chng_uuid;
         Ebeln      = ebeln;
         DelivDate  = deliv_date;
         ActionBy   = action_by;
         ActionTs   = action_ts;
         Comments   = comments;
         Sendemailstatus = sendemailstatus;
      }
   }
   ```
## Step 6 - Change in Metdata Definition
   ### ZC_EKKO_DMO
   ```
   
   @Metadata.layer: #CORE
   @UI: {
        headerInfo: { typeName: 'DelayedPO',
                        typeNamePlural: 'DelayedPOs',
                        title: { type: #STANDARD, label: 'Delayed PO', value: 'ChngUuid' } },
        presentationVariant: [{ sortOrder: [{ by: 'ChngUuid', direction:  #DESC }] }] }

   annotate view ZC_EKKO_DMO with 
   {
        @UI.facet: [ { id:              'DelayedPO',
                        purpose:         #STANDARD,
                        type:            #IDENTIFICATION_REFERENCE,
                        label:           'Delayed PO',
                        position:        10 } ]  

        @UI:{ identification: [{ position: 1, label: 'Change UUID' }] }
        
        ChngUuid;
        @UI: {  lineItem:       [ { position: 10 } ],
                identification: [ { position: 10 , label: 'Purchase Order' } ],
                selectionField: [ { position: 10 } ] }
        @Consumption.valueHelpDefinition: [{ entity: { element : 'ebeln', name: 'ZCDS_EKKO_DMO' },
                            additionalBinding: [{ localElement: 'supplier', element: 'supplier' },
                                                { localElement: 'supplier_name', element: 'supplier_name' },
                                                { localElement: 'OldDeliveryDate', element: 'final_del' } ] }] 
        Ebeln;
        @UI: {  lineItem:       [ { position: 20 } ],
                identification: [ { position: 20 , label: 'Supplier' } ],
                selectionField: [ { position: 20 } ] }

        supplier;
        @UI: {  lineItem:       [ { position: 30 } , { label: 'Supplier Name' } ],
                identification: [ { position: 30 , label: 'Supplier Name' } ],
                selectionField: [ { position: 30 } ] }  
        supplier_name;  
        @UI: {  lineItem:       [ { position: 40 }, { label: 'Delivery Date' } ],
                identification: [ { position: 40, label: 'Delivery Date' } ] }
        DelivDate;
        
        @UI: {  lineItem:       [ { position: 50 }, { label: 'Old Delivery Date' } ],
                identification: [ { position: 50 , label: 'Old Delivery Date' } ] }  
        OldDeliveryDate;
        
        @UI: {  lineItem:       [ { position: 60 } ],
                identification: [ { position: 60 , label: 'Action by ' } ] }
        ActionBy;
        @UI.hidden: true
        ActionTs;
        
        @UI: {  lineItem:       [ { position: 70 } ],
                identification: [ { position: 70 , label: 'Comments' } ] }
        Comments;
        
        @UI: {  lineItem:       [ { position: 80, label: 'Send Spool' }
                                    ,{ type: #FOR_ACTION, dataAction: 'SENDEMAIL', label: 'Send Spool' } ] ,
                identification: [ { position: 80, label: 'Send Spool' }]}  
        Sendemailstatus;  
   }  
   ```
## Step 7 - Implement Behaviour methods
   ### zcl_cekko_del_bd
   Use quickfix options in the Behaviour definition: ZC_EKKO_DMO, implement the class with the local class inheritation. Then implement the code as given here:
   [zcl_cekko_del_bd](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/zcl_cekko_del_bd%3Elhc_DelayedPO.abap)
   
   ### zcl_ekko_del_bd
   Use quickfix options in the Behaviour definition: ZI_EKKO_DMO, implement the class with the local class inheritation. Then implement the code as given here:
   [zcl_cekko_del_bd](https://github.com/sabarna17/ZEKKO_DELAY_ABAP/blob/main/zcl_cekko_del_bd%3Elhc_DelayedPO.abap)
   
## Step 8 - Create a sample SFP Adobe Form
   ### ZAF_TEST_PO_DEL_DELAY
   This adobe form is having below importing parameters:
   ```
   IV_PO
   IV_DATE
   IV_NAME
   IV_COMMENT
   ```
 
## Step 9 - Test your program

