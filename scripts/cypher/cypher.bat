@echo off
set JAVA_HOME=%CD%\zulu11.39.15-ca-jre11.0.7-win_x64
set PATH=%JAVA_HOME%\bin;%PATH%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

SET CYPHER_SHELL_JAR=%CD%\cypher-shell\cypher-shell.jar

"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %CYPHER_SHELL_OPTS%  -jar "%CYPHER_SHELL_JAR%" %CMD_LINE_ARGS%
