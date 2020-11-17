//6. Add embeddings to the in-memory graph
CALL gds.beta.graphSage.mutate(
  'retail_graph',
  {
    modelName: 'graphsage_multipartite_demo',
    mutateProperty:'Embedding'
  });