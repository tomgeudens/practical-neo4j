set apocVersion=4.1.0.4
set neo4jVersion=4.1.4
set gdsVersion=1.4.0
set zuluVersion=11.43.55
set jreVersion=11.0.9.1

set NEO4J_HOME=%CD%\neo4j-enterprise-%neo4jVersion%
set JAVA_HOME=%CD%\zulu%zuluVersion%-ca-jre%jreVersion%-win_x64
set PATH=%JAVA_HOME%\bin;%PATH%
