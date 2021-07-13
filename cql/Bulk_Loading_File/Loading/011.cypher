// 011 - Load the ACTED_IN relationships
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/basic/relationships/ACTED_IN.csv" AS row
  RETURN row
','
  MATCH  (p:Person {name: row.person })
  MATCH  (m:Movie  {title: row.movie})
  MERGE (p)-[a:ACTED_IN]->(m)
  ON CREATE SET a.roles = split(row.roles,";");
',{batchSize:2000, parallel:false});
