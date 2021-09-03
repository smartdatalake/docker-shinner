FROM spark-base:2.4.6

COPY start-submit-webserver.sh /
COPY start-submit-commandline.sh /
COPY start-submit-ercommandline.sh /
COPY ./gcore-spark/target /
COPY guice-4.0.jar /

ENV RESTAPI_PORT 6080
EXPOSE $RESTAPI_PORT

ENV SPARK_MASTER_URL="spark://spark-master:7077"
ENV SPARK_APPLICATION_WEBSERVER_ARGS="6080 /DemoGraphs"
ENV SPARK_MAIN_CLASS_WEBSERVER="application.WebServer"
ENV SPARK_SUBMIT_ARGS "--executor-memory 50g --driver-memory 50g --conf spark.driver.maxResultSize=4g --conf spark.serializer=org.apache.spark.serializer.KryoSerializer --conf spark.sql.shuffle.partitions=32 --conf spark.driver.extraClassPath=guice-4.0.jar --conf spark.shuffle.file.buffer=2m"
ENV SPARK_APPLICATION_WEBSERVER "gcore-interpreter-ggd-1.0-SNAPSHOT-allinone.jar"
ENV SPARK_APPLICATION_COMMANDLINE "gcore-interpreter-ggd-1.0-SNAPSHOT-jar-with-dependencies.jar"
ENV SPARK_MAIN_CLASS_COMMANDLINE="ggd.ERRunner"
ENV SPARK_MAIN_CLASS_ERCOMMANDLINE="sHINERrunner"
ENV SPARK_APPLICATION_ERCOMMANDLINE_ARGS="/Config/config.json /Config/comparison.json"
ENV SPARK_APPLICATION_COMMANDLINE_ARGS="/Config/configrunner.json"

#CMD ["/bin/bash", "/start-submit.sh"]
CMD ["/bin/bash", "/start-submit-commandline.sh"]
CMD ["/bin/bash", "/start-submit-ercommandline.sh"]
CMD ["/bin/bash", "/start-submit-webserver.sh"]
