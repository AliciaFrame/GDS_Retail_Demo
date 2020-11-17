//5. What are embeddings again?
CALL gds.beta.graphSage.stream(
  'retail_graph',
  {
    modelName: 'graphsage_multipartite_demo'
  });