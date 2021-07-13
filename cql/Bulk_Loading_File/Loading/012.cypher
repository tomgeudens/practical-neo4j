// 012 - Verify the ACTED_IN relationships
MATCH (:Person)-[:ACTED_IN]->(:Movie) 
RETURN count(*);
