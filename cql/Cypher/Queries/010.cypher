// 010 - WHERE can not create variables
MATCH (p:Person)
WHERE EXISTS( (p)-[:DIRECTED]->(m) )
RETURN p.name, m.title;
