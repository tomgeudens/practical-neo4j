// 003 - 3D pattern (with a quirk)
MATCH (p1:Person {name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(p2:Person),(m)<-[:ACTED_IN]-(p3:Person)
RETURN p1.name, p2.name, p3.name;
