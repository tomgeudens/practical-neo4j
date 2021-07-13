// 011 Create the relationship
MATCH (t:Training {title: "Basics"})
MATCH (tr:Trainer {name: "Tom Geudens"})
MERGE (tr)-[te:TEACHES {location: "Online", when: date("2021-03-19")}]->(t)
RETURN tr,te,t;
