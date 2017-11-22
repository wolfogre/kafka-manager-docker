FROM centos:7

RUN yum install -y java-1.8.0-openjdk-devel which unzip && \
    yum clean all && rm -rf /var/cache/yum

ARG version=1.3.3.14

RUN begintime=`date +%s` && \
    cd /opt && \
    curl https://codeload.github.com/yahoo/kafka-manager/tar.gz/${version} -o kafka-manager.tar.gz && \
    tar -xzvf kafka-manager.tar.gz && \
    mv kafka-manager-${version} kafka-manager && \
    rm -f kafka-manager.tar.gz && \
    cd kafka-manager && \
    ./sbt clean dist -v && \
    rm -rf ~/.ivy2 ~/.pki ~/.sbt && \
    cd /opt && \
    mv kafka-manager/target/universal/kafka-manager-${version}.zip ./ && \
    unzip kafka-manager-${version}.zip && \
    rm -rf kafka-manager && \
    mv kafka-manager-${version} kafka-manager && \
    ls -l -h kafka-manager-${version}.zip && \
    md5sum kafka-manager-${version}.zip && \
    endtime=`date +%s` && \
    echo "cost $[ (endtime - begintime) / 60 ] min"

WORKDIR /opt/kafka-manager

ENTRYPOINT ["bin/kafka-manager"]
    
