# Setting up Neo4j Enterprise Edition - Windows

**Disclaimer**: This document aims at getting a Neo4j database up-and-running in the context of a training or experiment. It is **not** fit for production installation purposes. It also assumes a single user developer installation and is in that respect similar to a Neo4j Desktop installation (which also provides the Enterprise Edition). For that purpose the Neo4j Enterprise Edition software requires no further licensing. For any other purpose … **it does** !

**Version**: this document is current for version **3.5.20**

**Last Update**: 2020/07/23 - APOC update

**Important**: All of the below is executed in a commandline window (cmd)  !

## One - Location Location Location

This document will assume everything (software, installation, database) is going to happen in a single **neo4j** folder (which is created below). This folder must reside in a location that is writable for the user with which you are logged on. No elevated rights will be needed (and try to avoid using an Administrator user). The **C:\users\<your user>\Documents** folder is perfect.

```
C:\Users\<youruser>\Documents>mkdir neo4j
C:\Users\<youruser>\Documents>mkdir neo4j\scripts
C:\Users\<youruser>\Documents>cd neo4j
C:\Users\<youruser>\Documents\neo4j>
```

