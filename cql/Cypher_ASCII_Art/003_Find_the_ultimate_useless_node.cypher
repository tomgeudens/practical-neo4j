// 003 - Find the ultimate useless node
MATCH (n) WHERE labels(n) = [] 
RETURN n;