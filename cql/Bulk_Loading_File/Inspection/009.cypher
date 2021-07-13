// 009 - Cleanup
CALL apoc.periodic.commit(
 "MATCH ()-[r]->() WITH r LIMIT $limit DELETE r RETURN count(*)",
 {limit:2000}
);
CALL apoc.periodic.commit(
 "MATCH (n) WITH n LIMIT $limit DELETE n RETURN count(*)",
 {limit:2000}
);
