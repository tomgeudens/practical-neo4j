package io.tomgeudens.neo4j.pregel;

import io.tomgeudens.neo4j.pregel.configuration.LabelPropagationPregelComputationConfiguration;
import org.neo4j.graphalgo.api.nodeproperties.ValueType;
import org.neo4j.graphalgo.beta.pregel.Messages;
import org.neo4j.graphalgo.beta.pregel.PregelComputation;
import org.neo4j.graphalgo.beta.pregel.PregelSchema;
import org.neo4j.graphalgo.beta.pregel.annotation.GDSMode;
import org.neo4j.graphalgo.beta.pregel.annotation.PregelProcedure;
import org.neo4j.graphalgo.beta.pregel.context.ComputeContext;
import org.neo4j.graphalgo.beta.pregel.context.InitContext;
import org.neo4j.graphalgo.beta.pregel.context.MasterComputeContext;

import java.util.*;

@PregelProcedure(name = "pregel.labelpropagation", modes = {GDSMode.STREAM, GDSMode.STATS}, description = "pregel computation label propagation")
public class LabelPropagationPregelComputation implements PregelComputation<LabelPropagationPregelComputationConfiguration> {

    public static final String LABELPROPAGATION = "label";

    @Override
    public PregelSchema schema(LabelPropagationPregelComputationConfiguration config) {
        return new PregelSchema.Builder().add(LABELPROPAGATION, ValueType.LONG).build();
    }

    @Override
    public void init(InitContext<LabelPropagationPregelComputationConfiguration> context) {
        // set starting label (every node gets it's nodeid)
        context.setNodeValue(LABELPROPAGATION, context.nodeId());
    }

    @Override
    public void compute(ComputeContext<LabelPropagationPregelComputationConfiguration> context, Messages messages) {
        long label = context.longNodeValue(LABELPROPAGATION);
        boolean votetohalt = false;

        if (!context.isInitialSuperstep()) {

            HashMap<Long, Long> neighbourlabels = new HashMap<>(10); // <label, count>

            for (var message : messages) {
                if (neighbourlabels.containsKey(message.longValue())) {
                    neighbourlabels.put(message.longValue(),neighbourlabels.get(message.longValue()) + 1L);
                } else {
                    neighbourlabels.put(message.longValue(),1L);
                }
            }

            if (!neighbourlabels.isEmpty()) {
                long highestvalue = 0;
                for (Map.Entry<Long, Long> neighbourlabel : neighbourlabels.entrySet()) {
                    if (neighbourlabel.getValue() > highestvalue) {
                        highestvalue = neighbourlabel.getValue();
                    }
                }

                List<Long> candidates = new ArrayList<>(10);
                for (Map.Entry<Long, Long> neighbourlabel : neighbourlabels.entrySet()) {
                    if (neighbourlabel.getValue() == highestvalue) {
                        candidates.add(neighbourlabel.getKey());
                    }
                }

                Random randomizer = new Random();
                long newlabel = candidates.get(randomizer.nextInt(candidates.size()));

                if (newlabel == label && (candidates.size() > neighbourlabels.size() / 2)) {
                    // votetohalt condition = majority of neighbours has my label
                    votetohalt = true;
                }

                label = newlabel;
                context.setNodeValue(LABELPROPAGATION, label);
            } else {
                votetohalt = true;
            }
        }
        // send all neighbours my label unless I want to halt (because then the majority already has it)
        if (! votetohalt) {
            context.sendToNeighbors(label);
        } else {
            context.voteToHalt();
        }
    }

    @Override
    public boolean masterCompute(MasterComputeContext<LabelPropagationPregelComputationConfiguration> context) {
        return PregelComputation.super.masterCompute(context);
    }
}
