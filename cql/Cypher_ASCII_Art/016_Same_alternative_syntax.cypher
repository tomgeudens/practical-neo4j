// 016 - Same (alternative syntax)
MATCH (:Person {name: "Tom Hanks"})--()
RETURN count(*);