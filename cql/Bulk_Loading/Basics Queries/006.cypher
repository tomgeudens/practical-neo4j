// 006 Did Tom act with Kevin ?
MATCH (p1:Person)-[a1:ACTED_IN]->(m:Movie)<-[a2:ACTED_IN]-(p2:Person)
WHERE p1.name = "Tom Hanks"
AND p2.name = "Kevin Bacon"
RETURN p1.name, a1.roles, p2.name, a2.roles, m.title;
