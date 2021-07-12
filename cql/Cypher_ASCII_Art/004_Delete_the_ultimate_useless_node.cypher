// 004 - Delete the ultimate useless node
MATCH (n) WHERE labels(n) = [] 
DELETE n;
