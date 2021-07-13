// 003 Person Nodes
LOAD CSV WITH HEADERS FROM 'http://data.neo4j.com/intro/movies/people.csv' AS row
CREATE (:Person {name: row.name, born: toInteger(row.born)});