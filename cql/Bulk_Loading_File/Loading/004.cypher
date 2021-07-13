// 004 - Create the Person nodes
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/basic/nodes/Person.csv" AS row
  RETURN row
','
  CREATE (:Person {name: row.name, born: toInteger(row.born)});
',{batchSize:2000, parallel:true});