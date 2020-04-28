// 3. different pageRanks
MATCH (i:Item) 
WHERE i.PageRank_Community_1052 > 1.5
AND i.PageRank_Community_2556 < .75
RETURN i.Description, i.PageRank_Community_1052, i.PageRank_Community_2556