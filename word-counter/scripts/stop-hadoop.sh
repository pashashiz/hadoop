#!/usr/bin/env bash
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
echo 'Stop Resource Manager...'
stop-yarn.sh
echo 'Stop hadoop...'
stop-dfs.sh