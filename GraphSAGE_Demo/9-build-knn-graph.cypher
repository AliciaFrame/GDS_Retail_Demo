// 9. build knn graph
//9. build knns graph
//graphsage
CALL gds.beta.knn.write('retail_graph', {
    writeRelationshipType: 'SIMILAR_GRAPHSAGE_EMBEDDING',
    writeProperty: 'score',
    topK: 3,
    randomSeed: 42,
    nodeWeightProperty: 'Embedding'
})
YIELD nodesCompared, relationshipsWritten;

//fastRPExtended
CALL gds.beta.knn.write({
     nodeProjection:'Item',
     relationshipProjection:'CONTAINS',
     nodeProperties:'fastrp-Embedding',
     writeRelationshipType: 'SIMILAR_FASTRP_EMBEDDING',
     writeProperty: 'score',
     topK: 3,
     randomSeed: 42,
     nodeWeightProperty: 'fastrp-Embedding'    
});