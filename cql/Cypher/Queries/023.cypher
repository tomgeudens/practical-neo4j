// 023 - How many times has a person acted and directed???
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH p, count(m) as acts
MATCH (p)-[:DIRECTED]->(m:Movie)
RETURN p.name, acts, count(m) as directs;
