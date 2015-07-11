#!/bin/sh
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
base=./..
echo 'Cleaning HDFS data...'
hdfs dfs -rm -r -skipTrash input/word-counter
hdfs dfs -rm -r -skipTrash output/word-counter
echo 'Cleaning local data...'
rm -R -f ${base}/output/*
echo 'Loading input data into HDFS...'
hdfs dfs -mkdir -p input
hdfs dfs -put ${base}/input input/word-counter
echo 'Run word-counter map-reduce programm...'
hadoop jar ${base}/target/word-counter.jar input/word-counter output/word-counter
hdfs dfs -get output/word-counter/* ${base}/output/
echo 'Result:'
cat ${base}/output/*