//2. load a multipartite graph

CALL gds.graph.create(
  'retail_graph',
  {
    Item: {
      label: 'Item',
      properties: {
        price: {
          property: 'Price',
          defaultValue: 0.0
        },
        StockCode: {
         property: 'StockCode',
         defaultValue: 0
       }
     }
    },
    Transaction: {
      label: 'Transaction',
      properties: {
       EpochTime:{
       	property:'EpochTime',
        defaultValue:0
       },
       TransactionID:{
       	property:'is_item',
        defaultValue:0
       }
     }
    }

 
 }, {
    
    CONTAINS: {
      type: 'CONTAINS',
      orientation: 'UNDIRECTED'
    }
})