#!/bin/bash

set -e

docker build -t spark-base:2.4.6 ./docker/base
docker build -t spark-master:2.4.6 ./docker/spark-master
docker build -t spark-worker:2.4.6 ./docker/spark-worker
docker build -t spark-submit:2.4.6 ./docker/spark-submit
#docker build -t spark-submit-brs:2.4.6 ./docker/spark-submit-brs
#docker build -t spark-submit-aql:2.4.6 ./docker/spark-submit-aql
