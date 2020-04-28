// 4. High centrality, low pagerank
MATCH (i:Item) 
WHERE i.PageRank_Community_1052 < .7
AND i.Closeness_Centrality_Community_1052 > .7
RETURN i.Description, i.PageRank_Community_1052, i.Closeness_Centrality_Community_1052