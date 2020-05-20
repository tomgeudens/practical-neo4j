CREATE CONSTRAINT ON (a:Account) ASSERT a.id IS UNIQUE;
CREATE CONSTRAINT ON (b:Bank) ASSERT b.id IS UNIQUE;
CREATE CONSTRAINT ON (p:Person) ASSERT p.id IS UNIQUE;
CREATE CONSTRAINT ON (c:Company) ASSERT c.id IS UNIQUE;
CREATE CONSTRAINT ON (co:Country) ASSERT co.id IS UNIQUE;
CREATE CONSTRAINT ON (l:Location) ASSERT l.id IS UNIQUE;

CREATE (b:Bank {id:1, name: "KBC Bank NV"})
CREATE (co1:Country {id:1, name: "Belgium"})
CREATE (co2:Country {id:2, name: "Panama"})
CREATE (a:Account {id:1, number: "XXXX-9999-ZZZ-888"})
CREATE (p1:Person {id:1, name: "Madelijn Lots"})
CREATE (p2:Person {id:2, name: "Tom Geudens"})
CREATE (c1:Company {id:1, name: "Elephant Bird Consulting BVBA"})
CREATE (c2:Company {id:2, name: "Elephant Bird Consulting Panama"})
CREATE (a1:Location {id:1, address: "Biezeweide 135, 1500 Halle"})
CREATE (a2:Location {id:2, address: "Parque Industrial Milla 8, Ciudad de Panama"})
CREATE (a3:Location {id:3, address: "Havenlaan 2, 1080 Brussel"})
MERGE (b)-[:ISSUED]->(a)
MERGE (p1)-[:HAS_ACCOUNT {since: "2012/03/14"}]->(a)
MERGE (p1)-[:LIVES_AT]->(a1)
MERGE (p2)-[:LIVES_AT]->(a1)
MERGE (p2)-[:OWNS]->(c1)
MERGE (c1)-[:LOCATED_AT]->(a1)
MERGE (c2)-[:LOCATED_AT]->(a2)
MERGE (b)-[:LOCATED_AT]->(a3)
MERGE (a1)-[:IS_IN]->(co1)
MERGE (a2)-[:IS_IN]->(co2)
MERGE (a3)-[:IS_IN]->(co1)
MERGE (c1)-[:HAS_SUBSIDIARY]->(c2);
