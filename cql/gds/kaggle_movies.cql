// based on an IMDB scrape found on Kaggle
// https://www.kaggle.com/stefanoleone992/imdb-extensive-dataset
// dataset represents situation on 2020/01/01 
CREATE CONSTRAINT uc_Movie_id ON (m:Movie) ASSERT m.id IS UNIQUE;
CREATE CONSTRAINT uc_Person_id ON (p:Person) ASSERT p.id IS UNIQUE;
CREATE INDEX index_Person_name FOR (p:Person) ON (p.name);
CREATE INDEX index_Movie_title FOR (m:Movie) ON (m.title);

//CREATE CONSTRAINT ON (m:Movie) ASSERT m.id IS UNIQUE;
//CREATE CONSTRAINT ON (p:Person) ASSERT p.id IS UNIQUE;
//CREATE INDEX ON :Person(name);
//CREATE INDEX ON :Movie(title);

// loading the Movie nodes
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/movie.csv" AS row
  RETURN row
','
  CREATE (:Movie {id: row.id, title: row.title, published: date(row.published)});
',{batchSize:20000, parallel:true});

// loading the Person nodes
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/person.csv" AS row
  RETURN row
','
  CREATE (:Person {id: row.id, name: row.name, height: toInteger(row.height), date_of_birth: date(row.date_of_birth), date_of_death: date(row.date_of_death)});
',{batchSize:20000, parallel:true});

// loading the DIRECTED relationships
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/director.csv" AS row
  RETURN row
','
  MATCH (m:Movie {id: row.movie})
  MATCH (p:Person {id: row.person})
  CREATE (p)-[:DIRECTED]->(m)
',{batchSize:20000, parallel:false});

// loading the ACTED_IN relationships
CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/actor.csv" AS row
  RETURN row
','
  MATCH (m:Movie {id: row.movie})
  MATCH (p:Person {id: row.person})
  CREATE (p)-[:ACTED_IN {role: row.role}]->(m)
',{batchSize:20000, parallel:false});

CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/producer.csv" AS row
  RETURN row
','
  MATCH (m:Movie {id: row.movie})
  MATCH (p:Person {id: row.person})
  CREATE (p)-[:PRODUCED]->(m)
',{batchSize:20000, parallel:false});

CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/writer.csv" AS row
  RETURN row
','
  MATCH (m:Movie {id: row.movie})
  MATCH (p:Person {id: row.person})
  CREATE (p)-[:WROTE]->(m)
',{batchSize:20000, parallel:false});

CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/composer.csv" AS row
  RETURN row
','
  MATCH (m:Movie {id: row.movie})
  MATCH (p:Person {id: row.person})
  CREATE (p)-[:COMPOSED_SCORE_FOR]->(m)
',{batchSize:20000, parallel:false});

CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/cinematographer.csv" AS row
  RETURN row
','
  MATCH (m:Movie {id: row.movie})
  MATCH (p:Person {id: row.person})
  CREATE (p)-[:DID_CINEMATOGRAPHY_FOR]->(m)
',{batchSize:20000, parallel:false});

CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/editor.csv" AS row
  RETURN row
','
  MATCH (m:Movie {id: row.movie})
  MATCH (p:Person {id: row.person})
  CREATE (p)-[:EDITED]->(m)
',{batchSize:20000, parallel:false});

CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/other.csv" AS row
  RETURN row
','
  MATCH (m:Movie {id: row.movie})
  MATCH (p:Person {id: row.person})
  CREATE (p)-[:DID_SOMETHING_FOR]->(m)
',{batchSize:20000, parallel:false});

CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/movie_genres.csv" AS row
  RETURN row
','
  MATCH (m:Movie {id: row.id})
  CALL apoc.create.addLabels( id(m), split(row.genres,",") ) YIELD node
  RETURN count(*)
',{batchSize:20000, parallel:false});

CALL apoc.periodic.iterate('
  LOAD CSV WITH HEADERS FROM "file:///movies/vote.csv" AS row
  RETURN row
','
  MATCH (m:Movie {id: row.id})
  SET m.average_vote = toFloat(row.average_vote), m.total_votes = toInteger(row.total_votes)
',{batchSize:20000, parallel:true});
