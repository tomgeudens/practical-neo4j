// 006 Verify DIRECTED Relationships
MATCH ()-[:DIRECTED]->() RETURN count(*);