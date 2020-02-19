FROM centos:7

RUN yum install -y -q epel-release && \
    yum install -y -q java-1.8.0-openjdk-devel which unzip nodejs && \
    yum clean all && rm -rf /var/cache/yum

ARG version=3.0.0.0

RUN cd /opt && \
    curl -sSL https://codeload.github.com/yahoo/CMAK/tar.gz/${version} -o CMAK.tar.gz && \
    tar -xzf CMAK.tar.gz && \
    mv CMAK-${version} CMAK && \
    rm -f CMAK.tar.gz && \
    cd CMAK && \
    while [[ -z $(yes r | ./sbt clean dist 1>&2 && echo "ok") ]]; do echo "retry sbt"; done && \
    rm -rf ~/.ivy2 ~/.pki ~/.sbt && \
    cd /opt && \
    mv CMAK/target/universal/CMAK-${version}.zip ./ && \
    rm -rf CMAK && \
    ls -l -h CMAK-${version}.zip && \
    md5sum CMAK-${version}.zip
