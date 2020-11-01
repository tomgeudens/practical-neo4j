set apocVersion=3.5.0.15
set neo4jVersion=3.5.22
set gdsVersion=1.1.6
set zuluVersion=8.48.0.53
set jreVersion=8.0.265

set NEO4J_HOME=%CD%\neo4j-enterprise-%neo4jVersion%
set JAVA_HOME=%CD%\zulu%zuluVersion%-ca-jre%jreVersion%-win_x64
set PATH=%JAVA_HOME%\bin;%PATH%
