//8. Louvain mutate
CALL gds.louvain.mutate('Customer_Similarity_Graph_Items',{relationshipTypes:['Similar'], relationshipWeightProperty:'score', mutateProperty:'louvainCommunity'});

//Write mutated result back
CALL gds.graph.writeNodeProperties('Customer_Similarity_Graph_Items',['louvainCommunity']);