// 004 Analyzing without finding Tom
EXPLAIN MATCH (p:Person {name: "Tom Hanks"})
RETURN p;
