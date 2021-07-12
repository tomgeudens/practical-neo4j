// 007 - How many one hop patterns start with Tom Hanks and end with a Movie node?
MATCH (:Person {name: "Tom Hanks"})-[]->(:Movie)
RETURN count(*);