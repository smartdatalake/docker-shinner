FROM ubuntu:18.04

#############UBUNTU
#RUN apt-get update \
#	&& apt-get install -y openjdk-8-jdk \
#	&& apt-get install -y curl 

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    openjdk-8-jdk \
    net-tools \
    curl \
    netcat \
    gnupg \
    libsnappy-dev \
    && rm -rf /var/lib/apt/lists/*

###################JAVA
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $PATH:$JAVA_HOME/bin	

ENV DAEMON_RUN=true
ENV SPARK_VERSION=2.4.7
ENV HADOOP_VERSION=2.8.6
ENV SCALA_VERSION=2.11.12
ENV SCALA_HOME=/usr/share/scala

RUN SCALA_SHA256_SUM=b11d7d33699ca4f60bc3b2b6858fd953e3de2b8522c943f4cda4b674316196a8 && \
    apt-get update && \
    apt-get -y install wget && \
    cd "/tmp" && \
    wget "http://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    echo "${SCALA_SHA256_SUM}" "scala-${SCALA_VERSION}.tgz" | sha256sum -c - && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    apt-get -y autoremove wget && \
    apt-get -y clean && \
    rm -rf "/tmp/"* \
           "/var/cache/apt" \
           "/usr/share/man" \
           "/usr/share/doc" \
           "/usr/share/doc-base" \
           "/usr/share/info/*" 
   
#############Scala instalation
RUN export PATH="/usr/local/sbt/bin:$PATH" 
#&& apt-get update && apt-get -y install wget && mkdir -p "/usr/local/sbt" && wget -qO - --no-check-certificate "https://cocl.us/sbt-0.13.16.tgz" | tar xz -C /usr/local/sbt --strip-components=1 && sbt sbtVersion

#RUN apk add --no-cache python3

#RUN wget --no-verbose http://apache.mirror.iphh.net/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
#      && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
#      && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

################# HADOOP
#ENV HADOOP_VERSION 2.8.5
#ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
#ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
#ENV PATH $PATH:$HADOOP_HOME/bin
#RUN curl -sL --retry 3 \
#  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
#  | gunzip \
#  | tar -x -C /usr/ \
# && rm -rf $HADOOP_HOME/share/doc \
# && chown -R root:root $HADOOP_HOME

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS

ENV HADOOP_VERSION 3.2.2
ENV HADOOP_URL https://mirror.klaus-uwe.me/apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
ENV HADOOP_ASC https://downloads.apache.org/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz.asc

RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -fSL "$HADOOP_ASC" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_HOME/bin/:$PATH

################### SPARK
ENV SPARK_VERSION 2.4.7
ENV SPARK_HOME /usr/spark
#ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
ENV PATH $PATH:${SPARK_HOME}/sbin

COPY ./spark $SPARK_HOME
RUN chown -R root:root $SPARK_HOME
