#!/bin/sh
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
base=./..
echo 'Cleaning HDFS data...'
hdfs dfs -rm -r -skipTrash output/put-merge
echo 'Cleaning local data...'
rm -R -f ${base}/output/*
echo 'Run put-merge programm...'
hadoop jar ${base}/target/put-merge.jar ${base}/input output/put-merge/merged-file.txt
hdfs dfs -get output/put-merge/merged-file.txt ${base}/output/
echo 'Result:'
cat ${base}/output/merged-file.txt