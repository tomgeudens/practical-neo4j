// 007 ACTED_IN Relationships
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/intro/movies/actors.csv'
AS row
MATCH (p:Person {name: row.person })
MATCH (m:Movie {title: row.movie})
MERGE (p)-[actedIn:ACTED_IN]->(m)
ON CREATE SET actedIn.roles = split(row.roles,';');