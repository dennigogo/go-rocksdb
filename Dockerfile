FROM golang:1.12-alpine

MAINTAINER dennigogo <dennigogo@gmail.com>

RUN apk update && \
    apk add linux-headers make bash git g++ gcc libc-dev zlib-dev bzip2-dev snappy-dev lz4-dev perl coreutils

RUN cd /tmp && wget https://github.com/facebook/zstd/archive/v1.1.3.tar.gz && \
    mv v1.1.3.tar.gz zstd-1.1.3.tar.gz && \
    tar zxvf zstd-1.1.3.tar.gz && \
    cd zstd-1.1.3 && \
    make && make install && \
    cd /tmp && rm -rf zstd-1.1.3

RUN cd /tmp && git clone https://github.com/gflags/gflags.git && \
    cd gflags && \
    git checkout v2.0 && \
    ./configure && make && make install && \
    cd /tmp && rm -rf gflags

RUN cd /tmp && git clone https://github.com/facebook/rocksdb.git && \
    cd rocksdb && \
    git checkout v6.4.6 && \
    DEBUG_LEVEL=0 make shared_lib install-shared && \
    cd /tmp && rm -rf rocksdb && \
    export LD_LIBRARY_PATH=/usr/local/lib
