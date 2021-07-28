package io.tomgeudens.neo4j.pregel;

import io.tomgeudens.neo4j.pregel.configuration.ExamplePregelComputationConfiguration;

import org.neo4j.graphalgo.api.nodeproperties.ValueType;
import org.neo4j.graphalgo.beta.pregel.Messages;
import org.neo4j.graphalgo.beta.pregel.PregelComputation;
import org.neo4j.graphalgo.beta.pregel.PregelSchema;
import org.neo4j.graphalgo.beta.pregel.annotation.GDSMode;
import org.neo4j.graphalgo.beta.pregel.annotation.PregelProcedure;
import org.neo4j.graphalgo.beta.pregel.context.ComputeContext;
import org.neo4j.graphalgo.beta.pregel.context.InitContext;

@PregelProcedure(name = "pregel.example", modes = {GDSMode.STREAM}, description = "pregel computation example")
public class ExamplePregelComputation implements PregelComputation<ExamplePregelComputationConfiguration> {

    public static final String KEY = "key";

    @Override
    public PregelSchema schema(ExamplePregelComputationConfiguration config) {
        // Declare a node schema with a single node value of type Long
        return new PregelSchema.Builder().add(KEY, ValueType.LONG).build();
    }

    @Override
    public void init(InitContext<ExamplePregelComputationConfiguration> context) {
        // Set node identifier as initial node value
        context.setNodeValue(KEY, context.nodeId());
    }

    @Override
    public void compute(ComputeContext<ExamplePregelComputationConfiguration> context, Messages messages) {
        // Silence is golden
        context.voteToHalt();
    }
}
