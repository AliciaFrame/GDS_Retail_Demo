//6. node similarity
CALL gds.nodeSimilarity.mutate('Customer_Similarity_Graph_Items', {mutateRelationshipType:'Similar', mutateProperty:'score',topK:10, similarityCutoff:0.1});