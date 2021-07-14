// 008 - update/create a property, add a label
MATCH (p:Person {name: "Emil Eifrem"})
SET p.actor = false, p:CEO;
