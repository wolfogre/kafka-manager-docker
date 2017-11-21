#!/bin/bash

set -ex

if [[ -z "$1" ]]; then
	echo "please input version, like './build-zip.sh 1.3.3.14'"
	exit 1
fi

version=$1

sudo yum install -y java-1.8.0-openjdk-devel which unzip

curl https://codeload.github.com/yahoo/kafka-manager/tar.gz/${version} -o kafka-manager.tar.gz
tar -xzvf kafka-manager.tar.gz
mv kafka-manager-${version} kafka-manager
rm -f kafka-manager.tar.gz

cd kafka-manager
./sbt clean dist -v
cd ..

mv kafka-manager/target/universal/kafka-manager-${version}.zip ./
rm -rf kafka-manager

md5sum kafka-manager-${version}.zip

echo "done! you got "kafka-manager-${version}.zip

