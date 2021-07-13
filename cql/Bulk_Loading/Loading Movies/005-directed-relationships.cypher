// 005 DIRECTED Relationships
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/intro/movies/directors.csv' AS row
MATCH (p:Person {name: row.person })
MATCH (m:Movie {title: row.movie})
MERGE (p)-[:DIRECTED]->(m);