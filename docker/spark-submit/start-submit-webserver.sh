#!/bin/bash

/usr/spark/bin/spark-submit \
--class ${SPARK_MAIN_CLASS_WEBSERVER} \
--master ${SPARK_MASTER_URL} \
--total-executor-cores 1 \
 ${SPARK_SUBMIT_ARGS} \
 ${SPARK_APPLICATION_WEBSERVER} \
 ${SPARK_APPLICATION_WEBSERVER_ARGS} \

