// 025 - Adding John Doe to the Matrix
MATCH (m:Movie {title: "The Matrix"})
CREATE pattern=(:Person {name: "John Doe"})-[:ACTED_IN {roles: ["Himself"]}]->(m)
RETURN pattern;