package io.tomgeudens.demo;

import org.neo4j.graphalgo.impl.util.PathImpl;
//import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Path;
import org.neo4j.graphdb.Transaction;
//import org.neo4j.logging.Log;
import org.neo4j.procedure.*;

import java.util.List;

/**
 * Experiments with Neo4j Functions
 *
 * @author Tom Geudens
 * @version 1.0.0
 * @since 2020-08-18
 */
public class Functions {
    // provides access to the database engine
    //@Context
    //public GraphDatabaseService mDatabase;

    // provides access to the current transaction
    @Context
    public Transaction mTransaction;

    // provides access to neo4j.log
    //@Context
    //public Log mLog;

    @UserFunction
    @Description("io.tomgeudens.demo.rebind('start, list') RETURNS path")
    public Path rebind(@Name(value = "start") Long start,
                       @Name(value = "list") List<Long> list) {
        PathImpl.Builder builder = new PathImpl.Builder(mTransaction.getNodeById(start));
        for (Long relationshipid : list) {
            builder = builder.push(mTransaction.getRelationshipById(relationshipid));
        }
        return builder.build();
    }
}
