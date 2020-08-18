package io.tomgeudens.demo;

import io.tomgeudens.demo.result.PlainPathResult;
import org.neo4j.graphdb.*;
import org.neo4j.graphdb.traversal.Evaluation;
import org.neo4j.graphdb.traversal.TraversalDescription;
import org.neo4j.graphdb.traversal.Uniqueness;
import org.neo4j.logging.Log;

import java.util.ArrayList;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.Phaser;

public class ParallelTraversal implements Runnable {
    private final GraphDatabaseService database;
    private final Log log;
    private Phaser phaser;
    private Long start;
    private String name;
    private String direction;
    private ArrayBlockingQueue<PlainPathResult> results;

    public ParallelTraversal(GraphDatabaseService database, Log log, Phaser phaser, Long start, String name, String direction, ArrayBlockingQueue<PlainPathResult> results) {
        this.database = database;
        this.log = log;
        this.phaser = phaser;
        this.start = start;
        this.name = name;
        this.direction = direction;
        this.results = results;
        phaser.register();
    }

    @Override
    public void run() {
        try(Transaction tx = database.beginTx()) {
            Node startnode = tx.getNodeById(start);

            if ( ! (startnode == null) ) {
                TraversalDescription traversal = tx.traversalDescription()
                        .depthFirst()
                        .uniqueness(Uniqueness.RELATIONSHIP_PATH) // unique hops, not necessarily unique nodes
                        .expand(PathExpanders.forTypeAndDirection(RelationshipType.withName(name), Direction.valueOf(direction)))
                        .evaluator(path -> {
                            if ( path.length() > 0 ) {
                                if (! path.endNode().hasRelationship(Direction.valueOf(direction), RelationshipType.withName(name))) {
                                    return Evaluation.INCLUDE_AND_PRUNE;
                                } else {
                                    return Evaluation.EXCLUDE_AND_CONTINUE;
                                }
                            } else {
                                return Evaluation.EXCLUDE_AND_CONTINUE;
                            }
                        });

                for ( Path path: traversal.traverse(startnode) ) {
                    ArrayList<Long> flattenpath = new ArrayList<>(50);
                    for ( Relationship relationship : path.relationships() ) {
                        flattenpath.add( relationship.getId() );
                    }
                    results.add(new PlainPathResult(start, flattenpath));
                }
            }

            tx.commit();
        } finally {
            phaser.arriveAndDeregister();
        }
    }
}
