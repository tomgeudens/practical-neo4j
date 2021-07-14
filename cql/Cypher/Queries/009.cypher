// 009 - This is NOT the same
MATCH (p:Person)-[:DIRECTED]->()
RETURN p.name;
