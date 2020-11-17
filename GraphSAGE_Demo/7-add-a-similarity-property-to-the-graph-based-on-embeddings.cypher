//7. Add a similarity property to the graph based on embeddings
CALL gds.beta.knn.write('retail_graph', {
    writeRelationshipType: 'SIMILAR_EMBEDDING',
    writeProperty: 'score',
    topK: 3,
    randomSeed: 42,
    nodeWeightProperty: 'Embedding'
})
YIELD nodesCompared, relationshipsWritten