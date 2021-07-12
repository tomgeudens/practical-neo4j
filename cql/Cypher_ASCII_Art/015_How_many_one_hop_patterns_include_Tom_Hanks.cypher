// 015 - How many one hop patterns include Tom Hanks?
MATCH (:Person {name: "Tom Hanks"})-[]-()
RETURN count(*);