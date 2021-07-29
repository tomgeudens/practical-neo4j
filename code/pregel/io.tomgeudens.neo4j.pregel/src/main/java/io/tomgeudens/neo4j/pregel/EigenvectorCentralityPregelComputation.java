package io.tomgeudens.neo4j.pregel;

import io.tomgeudens.neo4j.pregel.configuration.EigenvectorCentralityPregelComputationConfiguration;
import org.neo4j.graphalgo.api.nodeproperties.ValueType;
import org.neo4j.graphalgo.beta.pregel.Messages;
import org.neo4j.graphalgo.beta.pregel.PregelComputation;
import org.neo4j.graphalgo.beta.pregel.PregelSchema;
import org.neo4j.graphalgo.beta.pregel.Reducer;
import org.neo4j.graphalgo.beta.pregel.annotation.GDSMode;
import org.neo4j.graphalgo.beta.pregel.annotation.PregelProcedure;
import org.neo4j.graphalgo.beta.pregel.context.ComputeContext;
import org.neo4j.graphalgo.beta.pregel.context.InitContext;
import org.neo4j.graphalgo.beta.pregel.context.MasterComputeContext;

import java.util.Optional;

@PregelProcedure(name = "pregel.eigenvector", modes = {GDSMode.STREAM}, description = "pregel computation eigenvector centrality")
public class EigenvectorCentralityPregelComputation implements PregelComputation<EigenvectorCentralityPregelComputationConfiguration> {
    public static final String EIGENVECTOR = "score";

    @Override
    public PregelSchema schema(EigenvectorCentralityPregelComputationConfiguration config) {
        return new PregelSchema.Builder().add(EIGENVECTOR, ValueType.DOUBLE).build();
    }

    @Override
    public void init(InitContext<EigenvectorCentralityPregelComputationConfiguration> context) {
        // could be 1.0, we're immediately normalizing that ...
        // this kind of normalization is called L2 Normalization
        context.setNodeValue(EIGENVECTOR, 1.0 / Math.sqrt(context.nodeCount()));
    }

    @Override
    public void compute(ComputeContext<EigenvectorCentralityPregelComputationConfiguration> context, Messages messages) {
        double score = context.doubleNodeValue(EIGENVECTOR);

        // Couple of options here, in it's basic definition the calculation should only take into account the
        // values of the neighbours (read: the score is recomputed from zero). Variations exist (the GDS version
        // also adds the current score)
        if (!context.isInitialSuperstep()) {
            // recalculate score unless it's just been initialized
            double messagesum = 0.0;
            for (var message : messages) {
                messagesum += message;
            }

            // update accordingly
            score = messagesum;
            context.setNodeValue(EIGENVECTOR, score);
        }

        // send all neighbours our score
        context.sendToNeighbors(score);
    }

    @Override
    public boolean masterCompute(MasterComputeContext<EigenvectorCentralityPregelComputationConfiguration> context) {
        // TODO implement normalization here & check for convergence, GDS version has an example ...
        return PregelComputation.super.masterCompute(context);
    }

    @Override
    public Optional<Reducer> reducer() {  // there will be only one message per node ...
        return Optional.of(new Reducer.Sum());
    }
}
