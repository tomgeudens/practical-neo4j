// 008 - Loading at last!
LOAD CSV WITH HEADERS FROM "file:///movies/basic/nodes/Person.csv" AS row
CREATE (p:Person {name: row.name, born: toInteger(row.born)})
RETURN p;
