package io.tomgeudens.neo4j.pregel;

import io.tomgeudens.neo4j.pregel.configuration.MaximumRandomValuePregelComputationConfiguration;
import org.neo4j.graphalgo.api.nodeproperties.ValueType;
import org.neo4j.graphalgo.beta.pregel.Messages;
import org.neo4j.graphalgo.beta.pregel.PregelComputation;
import org.neo4j.graphalgo.beta.pregel.PregelSchema;
import org.neo4j.graphalgo.beta.pregel.annotation.GDSMode;
import org.neo4j.graphalgo.beta.pregel.annotation.PregelProcedure;
import org.neo4j.graphalgo.beta.pregel.context.ComputeContext;
import org.neo4j.graphalgo.beta.pregel.context.InitContext;

import java.util.Random;

@PregelProcedure(name = "pregel.maximumrandomvalue", modes = {GDSMode.STREAM, GDSMode.STATS}, description = "pregel computation maximum random value")
public class MaximumRandomValuePregelComputation implements PregelComputation<MaximumRandomValuePregelComputationConfiguration> {

    public static final String STARTVALUE_KEY = "startvalue";
    public static final String MAXIMUMVALUE_KEY = "maximumvalue";

    @Override
    public PregelSchema schema(MaximumRandomValuePregelComputationConfiguration config) {
        return new PregelSchema.Builder()
                .add(STARTVALUE_KEY, ValueType.LONG)
                .add(MAXIMUMVALUE_KEY,ValueType.LONG)
                .build();
    }

    @Override
    public void init(InitContext<MaximumRandomValuePregelComputationConfiguration> context) {
        long startvalue = new Random().nextLong();
        context.setNodeValue(STARTVALUE_KEY, startvalue);
        context.setNodeValue(MAXIMUMVALUE_KEY, startvalue);
    }

    @Override
    public void compute(ComputeContext<MaximumRandomValuePregelComputationConfiguration> context, Messages messages) {
        if (context.isInitialSuperstep()) {
            context.sendToNeighbors(context.longNodeValue(MAXIMUMVALUE_KEY));
        } else {
            if (messages != null) {
                for (var message : messages) {
                    long receivedvalue = message.longValue();
                    if (receivedvalue > context.longNodeValue(MAXIMUMVALUE_KEY)) {
                        context.setNodeValue(MAXIMUMVALUE_KEY, receivedvalue);
                        context.sendToNeighbors(receivedvalue);
                    }
                }
            }
        }
        // Silence is Golden
        context.voteToHalt();
    }
}
