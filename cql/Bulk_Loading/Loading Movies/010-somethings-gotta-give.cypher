// 010 Something's Gotta Give
MATCH (m:Movie) WHERE m.title STARTS WITH "Something"
RETURN m, keys(m);