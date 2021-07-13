// 009 - Load the DIRECTED relationships
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/basic/relationships/DIRECTED.csv" AS row
  RETURN row
','
  MATCH  (p:Person {name: row.person })
  MATCH  (m:Movie  {title: row.movie})
  MERGE (p)-[:DIRECTED]->(m);
',{batchSize:2000, parallel:false});
