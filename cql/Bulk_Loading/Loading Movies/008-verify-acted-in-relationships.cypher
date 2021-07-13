// 008 Verify ACTED_IN Relationships
MATCH ()-[:ACTED_IN]->() RETURN count(*);