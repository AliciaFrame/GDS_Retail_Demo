//1. find items that are similar in 1052 and not 2556
MATCH p=(i1:Item)-[r:SIMILAR_1052]->(i2) 
WHERE NOT (i1:Item)-[r:SIMILAR_2556]->(i2) 
AND r.score > .1 AND r.score < .8
RETURN i1.Description, i2.Description, r.score as score order by score desc