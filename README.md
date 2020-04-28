
# Graph Data Science Retail Demo

**April 28, 2020**

This repo contains the data, load scripts, and queries that were demonstrated during the [Connections: Graph Data Science](https://neo4j.com/connections/graph-data-science/) presentation “What is Graph Data Science, and Neo4j’s GDS Library” presentation.

To replicate the demo, create an empty Neo4j 4.0 database and install the [1.2 release](https://github.com/neo4j/graph-data-science/releases/tag/1.2.0-alpha01) of the Graph Data Science library. Copy the .csv files from the /data folder into your plugins directory, and execute the queries in load_data.cypher.

Each of the other folders (Customer Segmentation, Item Similarity, Item Centrality, and Exploratory Queries) contains the procedure calls and queries demonstrated during the presentation. 

**_Note_**: You _may_ need to change the Community IDs specified in the Item Similarity, Ite, Centrality, and Exploratory Queries to match the community IDs in your database. They are assigned based on seeds pulled from your internal node IDs, so they may be different in your database.
