FROM python:3.8.6-slim-buster

ARG ROCKSDB_DEPENDENCIES="g++ git make"

RUN apt-get update \
  && apt-get install -y $ROCKSDB_DEPENDENCIES \
  && rm -rf /var/lib/apt/lists/*

RUN cd /usr/src \
  && git clone --depth 1 --branch v6.14.5 https://github.com/facebook/rocksdb.git \
  && cd rocksdb \
  && make shared_lib \
  && make install-shared INSTALL_PATH=/usr

RUN apt-get autoremove -y --purge $ROCKSDB_DEPENDENCIES
