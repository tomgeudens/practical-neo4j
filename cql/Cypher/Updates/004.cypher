// 004 - Controlled delete of relationships ...
MATCH (p:Person {name: "Tom Geudens"})-[r]-()
// you could possibly do something with r here
DELETE r;
