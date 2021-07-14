// 006 - Map Projection
MATCH (p:Person {name: "Tom Hanks"})-[a:ACTED_IN]->(m:Movie)
RETURN {name: p.name, randomrole: apoc.coll.randomItem(a.roles), title: m.title} as result;
