// 004 - 3D pattern (more readable variant)
MATCH (p1:Person {name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(p2:Person)
MATCH (m)<-[:ACTED_IN]-(p3:Person)
RETURN p1.name, p2.name, p3.name;
