// 007 - WHERE makes it conditional
MATCH (p:Person)
WHERE p.name = "Tom Hanks"
RETURN p;
