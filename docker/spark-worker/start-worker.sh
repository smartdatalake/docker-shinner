#!/bin/bash

. "/usr/spark/sbin/spark-config.sh"
. "/usr/spark/bin/load-spark-env.sh"

mkdir -p $SPARK_WORKER_LOG

export SPARK_HOME=/usr/spark

ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker.out

/usr/spark/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_WORKER_LOG/spark-worker.out

