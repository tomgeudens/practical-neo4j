// 009 What is strange?
MATCH(p:Person {name: "Tom Hanks"})-[ai:ACTED_IN]-(m:Movie) RETURN p,ai,m;
