//1. customer similarity by category
CALL gds.graph.create.cypher(
	'Customer_Similarity_Graph_Category',
    'MATCH (n) WHERE n:Customer OR n:Category RETURN id(n) AS id',
    'MATCH (c:Customer)-->(:Transaction)-->(:Item)-->(c2:Category) RETURN id(c) as source, id(c2) as target'
)