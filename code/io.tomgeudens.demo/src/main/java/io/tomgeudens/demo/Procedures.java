package io.tomgeudens.demo;

import io.tomgeudens.demo.result.*;

import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Transaction;
import org.neo4j.logging.Log;
import org.neo4j.procedure.*;

import java.util.List;
import java.util.Map;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Phaser;
import java.util.stream.Stream;

import static org.neo4j.internal.helpers.collection.MapUtil.map;

/**
 * Experiments with Neo4j Procedures
 *
 * @author Tom Geudens
 * @version 1.0.0
 * @since 2020-08-17
 */
public class Procedures {
    // provides access to the database engine
    @Context
    public GraphDatabaseService mDatabase;

    // provides access to the current transaction
    @Context
    public Transaction mTransaction;

    // provides access to neo4j.log
    @Context
    public Log mLog;

    public static final int mCPUS = Runtime.getRuntime().availableProcessors();

    /**
     *
     */
    @Procedure(value = "io.tomgeudens.demo.paralleltraversal", mode = Mode.READ)
    @Description("io.tomgeudens.demo.paralleltraversal('batch')")
    public Stream<PlainPathResult> demoparalleltraversal(
            @Name(value = "batch") List<Map<String,Object>> batch,
            @Name(value = "name") String name,
            @Name(value = "direction") String direction
    ) {

        ArrayBlockingQueue<PlainPathResult> results = new ArrayBlockingQueue<PlainPathResult>(400 * mCPUS);
        ExecutorService service = Executors.newFixedThreadPool(mCPUS);
        Phaser phaser = new Phaser(1);

        for ( Map<String, Object> one : batch ) {
            Long start = null;
            for (Map.Entry<String, Object> entry : one.entrySet() ) {
                if ( entry.getKey().equals("start") )
                    start = (Long)entry.getValue();
            }
            if ( start == null )
                continue;
            service.submit(new ParallelTraversal(mDatabase, mLog, phaser, start, name, direction, results));
        }

        phaser.arriveAndAwaitAdvance();
        return results.stream();
    }

    /**
     * demohelp procedure
     * returns a stream of HelpResult objects containing possible functions or procedures matching the searchstring
     *
     * @author Tom Geudens
     * @param search string to look for functions and procedures
     * @since 2020-08-17
     */
    @Procedure(value = "io.tomgeudens.demo.help", mode = Mode.READ)
    @Description("io.tomgeudens.demo.help('searchstring')")
    public Stream<HelpResult> demohelp(@Name(value = "searchstring", defaultValue = "") String search) {

        String filter = " WHERE name STARTS WITH 'io.tomgeudens.demo' " +
                " AND ($name = '' OR toLower(name) CONTAINS toLower($name)) " +
                " RETURN type, name, description, signature ";

        String query = " WITH 'procedure' as type CALL dbms.procedures() yield name, description, signature " +
                filter +
                " UNION ALL " +
                " WITH 'function' as type CALL dbms.functions() yield name, description, signature " +
                filter;

        return  mTransaction.execute(query, map("name", search)).stream().map(HelpResult::new);
    }
}
