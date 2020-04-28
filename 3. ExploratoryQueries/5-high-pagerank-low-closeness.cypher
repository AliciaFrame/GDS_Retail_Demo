//5. high pagerank, low closeness
MATCH (i:Item) 
WHERE i.PageRank_Community_2556 > 1
AND i.Closeness_Centrality_Community_2556 < 0.75
RETURN i.Description, i.PageRank_Community_2556 as pageRank, i.Closeness_Centrality_Community_2556 as closeness order by pageRank DESC