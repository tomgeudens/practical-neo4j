// 006 - Controlled delete of relationships with intermediate commit ...
CALL apoc.periodic.commit(
  "MATCH ()-[r]->() WITH r LIMIT $limit DELETE r RETURN count(*)",
  {limit:2000}
);
