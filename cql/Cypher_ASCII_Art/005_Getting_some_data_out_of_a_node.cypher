// 005 - Getting some data out of a node
MATCH (p:Person {name: "Tom Hanks"})-[]->(x)
RETURN x.title;