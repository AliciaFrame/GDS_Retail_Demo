//3. Train GraphSAGE

CALL gds.beta.graphSage.train(
  'retail_graph',
  {
    modelName: 'graphsage_multipartite_demo',
    //which features should we use? all of them!
    featureProperties: ['price', 'quantity','StockCode','EpochTime','TransactionID'],
    //specify the projected feature dimension
    projectedFeatureDimension:7, //2 labels + 5 properties
    degreeAsProperty: true, //adding more properties
    epochs: 3, //how many times to traverse the graph during training
    searchDepth:5 //depth of the random walk
  }
)
