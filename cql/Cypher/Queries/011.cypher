// 011 - Use EXISTS, avoid NULL
MATCH (p:Person)
WHERE NOT EXISTS( p.born )
RETURN p.name;
