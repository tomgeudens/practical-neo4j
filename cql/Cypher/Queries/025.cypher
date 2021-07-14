// 025 - Bad Idea
MATCH (p:Person)
OPTIONAL MATCH (p)-[:ACTED_IN]->(m:Movie)
WITH p, count(m) as acts
OPTIONAL MATCH (p)-[:DIRECTED]->(m:Movie)
RETURN p.name, acts, count(m) as directs;
