// 7. create a monopartite projection

CALL gds.alpha.collapsePath.mutate(
  'retail_graph',
  {
    relationshipTypes: ['CONTAINS', 'CONTAINS'],
    allowSelfLoops: false,
    mutateRelationshipType: 'BOUGHT_TOGETHER'
  }
) YIELD relationshipsWritten