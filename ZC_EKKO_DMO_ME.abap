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
//  @UI: {  lineItem:       [ { position: 10 } ],
//          identification: [ { position: 10 , label: 'Change UUID' } ] }   
  ChngUuid;
  @UI: {  lineItem:       [ { position: 10 } ],
          identification: [ { position: 10 , label: 'Purchase Order' } ],
          selectionField: [ { position: 10 } ] }
  @Consumption.valueHelpDefinition: [{ entity: { element : 'ebeln', name: 'ZCDS_EKKO_DMO' },
                      additionalBinding: [{ localElement: 'supplier', element: 'supplier' },
                                          { localElement: 'supplier_name', element: 'supplier_name' }] }] 
  Ebeln;
  @UI: {  lineItem:       [ { position: 20 } ],
          identification: [ { position: 20 , label: 'Supplier' } ],
          selectionField: [ { position: 20 } ] }
//  @Consumption.valueHelpDefinition: [{ entity: { element : 'Supplier', name: 'ZCDS_EKKO_DMO' } }]  
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
  
  @UI: {  lineItem:       [ { position: 60 } ],
          identification: [ { position: 60 , label: 'Comments' } ] }
  Comments;
}
