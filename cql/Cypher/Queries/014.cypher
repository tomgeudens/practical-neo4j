// 014 - Profiling Tom Hanks - WHERE
PROFILE MATCH (p:Person)
WHERE p.name = "Tom Hanks"
RETURN p;
