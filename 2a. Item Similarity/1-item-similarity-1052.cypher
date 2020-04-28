// 1. Item similarity - 1052
CALL gds.graph.drop('Customer_Similarity_Graph_Items');

// item similarity louvain 1052
CALL gds.graph.create.cypher(
	'Item_Similarity_1052',
    'MATCH (n) WHERE n:Transaction or n:Item return id(n) as id',
    'MATCH (t:Transaction)<--(c:Customer) WHERE c.louvainCommunity = 1052 WITH t MATCH (i:Item)<--(t) RETURN distinct id(i) as source, id(t) as target'
);

//mutate for item sim 1052
CALL gds.nodeSimilarity.mutate('Item_Similarity_1052',{mutateRelationshipType:'SIMILAR_1052', mutateProperty:'score'});

//write new relationship back
CALL gds.graph.writeRelationship('Item_Similarity_1052','SIMILAR_1052','score');

//drop graph
CALL gds.graph.drop('Item_Similarity_1052');