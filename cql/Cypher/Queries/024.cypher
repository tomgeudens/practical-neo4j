// 024 - Pattern Comprehension
MATCH (p:Person)
RETURN p.name, 
 size([(p)-[:ACTED_IN]->(m:Movie) | m]) as acts,
 size([(p)-[:DIRECTED]->(m:Movie) | m]) as directs;