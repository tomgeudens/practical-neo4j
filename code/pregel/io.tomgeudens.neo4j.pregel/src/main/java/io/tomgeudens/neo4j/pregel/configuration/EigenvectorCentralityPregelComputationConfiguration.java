package io.tomgeudens.neo4j.pregel.configuration;

import org.neo4j.graphalgo.annotation.Configuration;
import org.neo4j.graphalgo.annotation.ValueClass;
import org.neo4j.graphalgo.beta.pregel.PregelProcedureConfig;
import org.neo4j.graphalgo.config.GraphCreateConfig;
import org.neo4j.graphalgo.core.CypherMapWrapper;

import java.util.Optional;

@ValueClass
@SuppressWarnings("immutables:subtype")
@Configuration
public interface EigenvectorCentralityPregelComputationConfiguration extends PregelProcedureConfig {
    static EigenvectorCentralityPregelComputationConfiguration of (
            String username,
            @SuppressWarnings("OptionalUsedAsFieldOrParameterType") Optional<String> graphName,
            @SuppressWarnings("OptionalUsedAsFieldOrParameterType") Optional<GraphCreateConfig> maybeImplicitCreate,
            CypherMapWrapper userInput
    ){
        return new EigenvectorCentralityPregelComputationConfigurationImpl(graphName, maybeImplicitCreate, username, userInput);
    }
}
