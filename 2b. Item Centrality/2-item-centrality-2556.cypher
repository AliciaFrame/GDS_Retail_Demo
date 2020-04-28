//2. item centrality - 2556
CALL gds.graph.create.cypher('item_copurchase_2556','MATCH (i:Item)<--(c:Customer) where c.louvainCommunity = 2556 RETURN id(i) as id','MATCH (i1:Item)<--(c:Customer)-->(i2:Item) WHERE c.louvainCommunity = 2556 RETURN distinct id(i1) as source, id(i2) as target, count(c) as weight');

//item closeness
CALL gds.alpha.closeness.write('item_copurchase_2556',{writeProperty:'Closeness_Centrality_Community_2556'});

//item pagerank
CALL gds.pageRank.write('item_copurchase_2556',{relationshipWeightProperty:'weight',writeProperty:'PageRank_Community_2556'});

//drop graph
CALL gds.graph.drop('item_copurchase_2556');