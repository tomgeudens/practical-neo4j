package io.tomgeudens.neo4j.pregel;

import io.tomgeudens.neo4j.pregel.configuration.PageRankPregelComputationConfiguration;

import org.neo4j.graphalgo.api.nodeproperties.ValueType;
import org.neo4j.graphalgo.beta.pregel.Messages;
import org.neo4j.graphalgo.beta.pregel.PregelComputation;
import org.neo4j.graphalgo.beta.pregel.PregelSchema;
import org.neo4j.graphalgo.beta.pregel.Reducer;
import org.neo4j.graphalgo.beta.pregel.annotation.GDSMode;
import org.neo4j.graphalgo.beta.pregel.annotation.PregelProcedure;
import org.neo4j.graphalgo.beta.pregel.context.ComputeContext;
import org.neo4j.graphalgo.beta.pregel.context.InitContext;

import java.util.Optional;

@PregelProcedure(name = "pregel.pagerank", modes = {GDSMode.STREAM}, description = "pregel computation pagerank")
public class PageRankPregelComputation implements PregelComputation<PageRankPregelComputationConfiguration>  {

    public static final String PAGERANK = "pagerank";

    @Override
    public PregelSchema schema(PageRankPregelComputationConfiguration config) {
        return new PregelSchema.Builder().add(PAGERANK, ValueType.DOUBLE).build();
    }

    @Override
    public void init(InitContext<PageRankPregelComputationConfiguration> context) {
        // set starting rank (every node gets an equal share)
        context.setNodeValue(PAGERANK, 1.0 / context.nodeCount());
    }

    @Override
    public void compute(ComputeContext<PageRankPregelComputationConfiguration> context, Messages messages) {
        double pagerank = context.doubleNodeValue(PAGERANK);

        if (!context.isInitialSuperstep()) {
            // recalculate pagerank unless it's just been initialized
            double messagesum = 0.0;
            double jumpingFactor = 1.0 - context.config().dampingFactor();

            for (var message : messages) {
                messagesum += message;
            }

            pagerank = jumpingFactor / context.nodeCount() + context.config().dampingFactor() * messagesum;

            context.setNodeValue(PAGERANK, pagerank);
        }

        // send all neighbours a portion
        context.sendToNeighbors(pagerank / context.degree());
    }

    @Override
    public Optional<Reducer> reducer() { // there will be only one message per node ...
        return Optional.of(new Reducer.Sum());
    }
}