// Neo4j Movies (intro) Bulk Loading Script

// schema
CREATE CONSTRAINT cu_Movie_title ON (m:Movie) ASSERT m.title IS UNIQUE;
CREATE CONSTRAINT cu_Person_name ON (p:Person) ASSERT p.name IS UNIQUE;
CREATE INDEX i_Movie_tagline FOR (m:Movie) ON (m.tagline);

// Movie nodes
// using an APOC procedure to have a consistent script and allow
// parallel loading
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "http://data.neo4j.com/intro/movies/movies.csv" AS row
  RETURN row
','
  CREATE (:Movie {title: row.title, released: toInteger(row.released), tagline: row.tagline});
',{batchSize:10000, parallel:true});

// Person nodes
// using an APOC procedure to have a consistent script and allow
// parallel loading
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "http://data.neo4j.com/intro/movies/people.csv" AS row
  RETURN row
','
  CREATE (:Person {name: row.name, born: toInteger(row.born)});
',{batchSize:10000, parallel:true});

// ACTED_IN relationships
// using an APOC procedure to have a consistent script
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "http://data.neo4j.com/intro/movies/actors.csv" AS row
  RETURN row
','
  MATCH  (p:Person {name: row.person })
  MATCH  (m:Movie  {title: row.movie})
  UNWIND split(row.roles,";") AS role
  MERGE (p)-[:ACTED_IN {role: role}]->(m);
',{batchSize:10000, parallel:false});

// DIRECTED relationships
// using an APOC procedure to have a consistent script
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "http://data.neo4j.com/intro/movies/directors.csv" AS row
  RETURN row
','
  MATCH  (p:Person {name: row.person })
  MATCH  (m:Movie  {title: row.movie})
  MERGE (p)-[:DIRECTED]->(m);
',{batchSize:10000, parallel:false});
