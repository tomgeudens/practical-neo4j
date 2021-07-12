// 021 - Getting all the relevant data
MATCH (p:Person {name: "Tom Hanks"})-[f:ACTED_IN]->(m:Movie)
RETURN p.name, f.roles, m.title;