//8. FastRP Embeddings
CALL gds.beta.fastRPExtended.write(
  'retail_graph',
  {
    nodeLabels:['Item'],
    relationshipTypes:['BOUGHT_TOGETHER'],
    featureProperties:['price','quantity'],
    embeddingDimension: 10,
    propertyDimension:4, //good starting point: 2x the number of properties, must be less than embeddingDimension
    writeProperty: 'fastrp-Embedding'
  }
)
YIELD nodePropertiesWritten