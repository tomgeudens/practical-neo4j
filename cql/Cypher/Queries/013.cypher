// 013 - Excluding oneself, correct 3D pattern (three matches)
MATCH (p1:Person {name: "Tom Hanks"})-[:ACTED_IN]->(m:Movie)
MATCH (m)<-[:ACTED_IN]-(p2:Person)
MATCH (m)<-[:ACTED_IN]-(p3:Person)
WHERE p1 <> p3 AND p2 <> p3 AND p1 <> p2
RETURN p1.name, p2.name, p3.name;
