// 007 - Controlled delete of nodes with intermediate commit ...
CALL apoc.periodic.commit(
  "MATCH (n) WITH n LIMIT $limit DELETE n RETURN count(*)",
  {limit:2000}
);
