package io.tomgeudens.neo4j.pregel;

import io.tomgeudens.neo4j.pregel.configuration.MaximumPropertyValuePregelComputationConfiguration;

import org.neo4j.graphalgo.api.nodeproperties.ValueType;

import org.neo4j.graphalgo.beta.pregel.Messages;
import org.neo4j.graphalgo.beta.pregel.PregelComputation;
import org.neo4j.graphalgo.beta.pregel.PregelSchema;
import org.neo4j.graphalgo.beta.pregel.annotation.GDSMode;
import org.neo4j.graphalgo.beta.pregel.annotation.PregelProcedure;
import org.neo4j.graphalgo.beta.pregel.context.ComputeContext;
import org.neo4j.graphalgo.beta.pregel.context.InitContext;

@PregelProcedure(name = "pregel.maximumpropertyvalue", modes = {GDSMode.STREAM, GDSMode.STATS, GDSMode.WRITE}, description = "pregel computation maximum property value")
public class MaximumPropertyValuePregelComputation implements PregelComputation<MaximumPropertyValuePregelComputationConfiguration> {

    public static final String MAXIMUMVALUE_KEY = "maximumvalue";
    public static final String INTERMEDIATES_KEY = "intermediates";

    @Override
    public PregelSchema schema(MaximumPropertyValuePregelComputationConfiguration config) {
        return new PregelSchema.Builder()
                .add(MAXIMUMVALUE_KEY,ValueType.LONG)
                .add(INTERMEDIATES_KEY,ValueType.LONG_ARRAY)
                .build();
    }

    @Override
    public void init(InitContext<MaximumPropertyValuePregelComputationConfiguration> context) {
        context.setNodeValue(MAXIMUMVALUE_KEY, context.nodeProperties(context.config().key()).longValue(context.nodeId()));
        long[] intermediates = new long[context.config().maxIterations()];
        for (int i = 0; i < context.config().maxIterations(); i++) {
            intermediates[i] = 0;
        }
        context.setNodeValue(INTERMEDIATES_KEY, intermediates);
    }

    @Override
    public void compute(ComputeContext<MaximumPropertyValuePregelComputationConfiguration> context, Messages messages) {
        long[] intermediates = context.longArrayNodeValue(INTERMEDIATES_KEY);
        intermediates[context.superstep()] = context.longNodeValue(MAXIMUMVALUE_KEY);
        context.setNodeValue(INTERMEDIATES_KEY, intermediates);

        if (context.isInitialSuperstep()) {
            context.sendToNeighbors(context.longNodeValue(MAXIMUMVALUE_KEY));
        } else {
            if (messages != null) {
                boolean change = false; // keeping track of change
                for (var message : messages) {
                    long receivedvalue = message.longValue();
                    if (receivedvalue > context.longNodeValue(MAXIMUMVALUE_KEY)) {
                        context.setNodeValue(MAXIMUMVALUE_KEY, receivedvalue);
                        change = true;
                    }
                }
                if (change) { // only message if there was change
                    context.sendToNeighbors(context.longNodeValue(MAXIMUMVALUE_KEY));
                }
            }
        }
        // Silence is Golden
        context.voteToHalt();
    }
}
