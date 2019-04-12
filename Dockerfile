FROM centos:7

RUN yum install -y -q epel-release && \
    yum install -y -q java-1.8.0-openjdk-devel which unzip nodejs && \
    yum clean all && rm -rf /var/cache/yum

ARG version=2.0.0.2

RUN cd /opt && \
    curl -sSL https://codeload.github.com/yahoo/kafka-manager/tar.gz/${version} -o kafka-manager.tar.gz && \
    tar -xzf kafka-manager.tar.gz && \
    mv kafka-manager-${version} kafka-manager && \
    rm -f kafka-manager.tar.gz && \
    cd kafka-manager && \
    while [[ -z $(yes r | ./sbt clean dist 1>&2 && echo "ok") ]]; do echo "retry sbt"; done && \
    rm -rf ~/.ivy2 ~/.pki ~/.sbt && \
    cd /opt && \
    mv kafka-manager/target/universal/kafka-manager-${version}.zip ./ && \
    rm -rf kafka-manager && \
    ls -l -h kafka-manager-${version}.zip && \
    md5sum kafka-manager-${version}.zip
