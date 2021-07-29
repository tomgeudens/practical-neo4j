package io.tomgeudens.neo4j.pregel;

import io.tomgeudens.neo4j.pregel.configuration.ImmutableMaximumPropertyValuePregelComputationConfiguration;
import org.junit.jupiter.api.Test;
import org.neo4j.graphalgo.Orientation;
import org.neo4j.graphalgo.beta.pregel.Pregel;
import org.neo4j.graphalgo.core.concurrency.Pools;
import org.neo4j.graphalgo.core.utils.ProgressLogger;
import org.neo4j.graphalgo.core.utils.mem.AllocationTracker;
import org.neo4j.graphalgo.core.utils.paged.HugeLongArray;
import org.neo4j.graphalgo.extension.GdlExtension;
import org.neo4j.graphalgo.extension.GdlGraph;
import org.neo4j.graphalgo.extension.Inject;
import org.neo4j.graphalgo.extension.TestGraph;

import java.util.HashMap;

import static org.neo4j.graphalgo.TestSupport.assertLongValues;
import static io.tomgeudens.neo4j.pregel.MaximumPropertyValuePregelComputation.MAXIMUMVALUE_KEY;

@GdlExtension
public class MaximumPropertyValuePregelComputationTest {
    @GdlGraph(orientation = Orientation.NATURAL)
    private static final String TEST_GRAPH =
            "CREATE " +
            "(pe1:Person {id: 0, value: 3})," +
            "(pe2:Person {id: 1, value: 6})," +
            "(pe3:Person {id: 2, value: 2})," +
            "(pe4:Person {id: 3, value: 1})," +
            "(pe1)-[:FOLLOWS]->(pe2)," +
            "(pe2)-[:FOLLOWS]->(pe1)," +
            "(pe2)-[:FOLLOWS]->(pe4)," +
            "(pe3)-[:FOLLOWS]->(pe2)," +
            "(pe3)-[:FOLLOWS]->(pe4)," +
            "(pe4)-[:FOLLOWS]->(pe3)";

    @Inject
    private TestGraph graph;

    @Test
    void iterationOne() {
        int maxIterations = 1;
        var config = ImmutableMaximumPropertyValuePregelComputationConfiguration.builder()
                .maxIterations(maxIterations)
                .isAsynchronous(false)
                .build();

        var pregelJob = Pregel.create(
                graph,
                config,
                new MaximumPropertyValuePregelComputation(),
                Pools.DEFAULT,
                AllocationTracker.empty(),
                ProgressLogger.NULL_LOGGER
        );

        HugeLongArray nodeValues = pregelJob.run().nodeValues().longProperties(MAXIMUMVALUE_KEY);
        HashMap<String, Long> expected = new HashMap<>(4);
        expected.put("a", 3L);
        expected.put("b", 6L);
        expected.put("c", 2L);
        expected.put("d", 1L);

        assertLongValues(graph, nodeValues::get, expected);
    }
}
