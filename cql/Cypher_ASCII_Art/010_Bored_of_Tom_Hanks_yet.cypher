// 010 - Bored of Tom Hanks yet?
MATCH (p:Person {name: "Tom Hanks"})-[]->(f:Movie)
RETURN p.name, f.title;