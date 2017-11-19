FROM centos:7

RUN yum install -y java-1.8.0-openjdk which && \
    yum clean all && rm -rf /var/cache/yum

ARG version=1.3.3.14

RUN cd /opt && \
    curl https://codeload.github.com/yahoo/kafka-manager/tar.gz/${version} -o kafka-manager.tar.gz && \
    tar -xzvf kafka-manager.tar.gz && \
    mv kafka-manager-${version} kafka-manager && \
    rm -f kafka-manager.tar.gz && \
    cd kafka-manager && \
    ./sbt clean dist -v    
    
