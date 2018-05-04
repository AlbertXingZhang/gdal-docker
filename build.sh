#!/bin/sh
set -xe

cd /tmp
apt-get update
apt-get install -y wget make libgdal-dev openjdk-8-jdk

wget http://releases.llvm.org/6.0.0/clang+llvm-6.0.0-x86_64-linux-gnu-debian8.tar.xz
tar xJf clang+llvm-6.0.0-x86_64-linux-gnu-debian8.tar.xz
mv clang+llvm-6.0.0-x86_64-linux-gnu-debian8 clang

wget http://download.osgeo.org/gdal/2.2.4/gdal-2.2.4.tar.xz
tar xJf gdal-2.2.4.tar.xz
mv gdal-2.2.4 gdal

cd gdal
CC=/tmp/clang/bin/clang CXX=/tmp/clang/bin/clang++ ./configure --with-java --with-mdb --with-jvm-lib-add-rpath --without-libtool --with-static-proj4 --with-mysql --with-spatialite --with-poppler --with-jpeg12
make -j3
make install

cd /tmp
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mdb-sqlite/mdb-sqlite-1.0.2.tar.bz2
tar xjvf mdb-sqlite-1.0.2.tar.bz2
cp mdb-sqlite-1.0.2/lib/*.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext

apt-get install -y libgdal20 openjdk-8-jre
apt-get autoremove -y --purge wget make libgdal-dev openjdk-8-jdk
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
