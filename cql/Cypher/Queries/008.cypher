// 008 - WHERE can check patterns
MATCH (p:Person)
WHERE EXISTS( (p)-[:DIRECTED]->() )
RETURN p.name;
