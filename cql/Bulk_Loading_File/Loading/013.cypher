// 013 - Is there something strange here?
MATCH (p:Person {name: "Tom Hanks"})-[a:ACTED_IN]->(m:Movie) 
RETURN p,a,m;
