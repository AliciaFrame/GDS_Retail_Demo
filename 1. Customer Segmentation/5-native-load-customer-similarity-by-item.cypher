//5. native load - Customer Similarity by Item 
CALL gds.graph.create(
	'Customer_Similarity_Graph_Items',
    ['Customer','Item'],
    'BOUGHT'
)