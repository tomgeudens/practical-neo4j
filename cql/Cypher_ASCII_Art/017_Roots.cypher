// 017 - Roots
MATCH (n) 
WHERE NOT EXISTS ( (n)-[]->() )
RETURN count(*);