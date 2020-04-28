// 2. Item similarity - 2556

// item similarity louvain 2556
CALL gds.graph.create.cypher(
	'Item_Similarity_2556',
    'MATCH (n) WHERE n:Transaction or n:Item return id(n) as id',
    'MATCH (t:Transaction)<--(c:Customer) WHERE c.louvainCommunity = 2556 WITH t MATCH (i:Item)<--(t) RETURN distinct id(i) as source, id(t) as target'
);

//mutate for item sim 1052
CALL gds.nodeSimilarity.mutate('Item_Similarity_2556',{mutateRelationshipType:'SIMILAR_2556', mutateProperty:'score'});

//write new relationship back
CALL gds.graph.writeRelationship('Item_Similarity_2556','SIMILAR_2556','score');

//drop graph
CALL gds.graph.drop('Item_Similarity_2556');