. ./scripts/version.sh

export NEO4J_HOME=$(pwd)/neo4j-enterprise-${neo4jVersion}
export JAVA_HOME=$(pwd)/zulu${zuluVersion}-ca-jre${jreVersion}-macosx_x64
export PATH=$JAVA_HOME/bin:$PATH
