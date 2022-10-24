. ./scripts/version.sh

export NEO4J_HOME="$(pwd)/neo4j-enterprise-${neo4jVersion}"
export JAVA_HOME="$(pwd)/jdk-${temurinHomeVersion}-jre"
export PATH="$JAVA_HOME/bin:$PATH"
export NEO4J_ACCEPT_LICENSE_AGREEMENT="yes"
