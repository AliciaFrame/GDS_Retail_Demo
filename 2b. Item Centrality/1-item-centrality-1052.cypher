//1. item centrality - 1052
CALL gds.graph.create.cypher('item_copurchase_1052','MATCH (i:Item)<--(c:Customer) where c.louvainCommunity = 1052 RETURN id(i) as id','MATCH (i1:Item)<--(c:Customer)-->(i2:Item) WHERE c.louvainCommunity = 1052 RETURN distinct id(i1) as source, id(i2) as target, count(c) as weight');

//item closeness
CALL gds.alpha.closeness.write('item_copurchase_1052',{writeProperty:'Closeness_Centrality_Community_1052'});

//item pagerank
CALL gds.pageRank.write('item_copurchase_1052',{relationshipWeightProperty:'weight',writeProperty:'PageRank_Community_1052'});

//drop graph
CALL gds.graph.drop('item_copurchase_1052');