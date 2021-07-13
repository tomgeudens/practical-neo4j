// 010 - Verify the DIRECTED relationships
MATCH (:Person)-[:DIRECTED]->(:Movie) 
RETURN count(*);
