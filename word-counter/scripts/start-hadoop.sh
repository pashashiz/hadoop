#!/usr/bin/env bash
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
#echo 'Format NameNode...'
#hdfs namenode -format
echo 'Start NameNode and DataNode deamons...'
start-dfs.sh
echo 'Start Resource Manager...'
start-yarn.sh
echo 'Prepare user directory in HDFS'
hdfs dfs -mkdir /user
hdfs dfs -mkdir /user/${USER}