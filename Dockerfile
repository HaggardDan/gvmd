FROM debian:buster as gvmd-builder

RUN apt-get update && apt-get install -y \
    gcc \
    cmake \
    pkg-config \
    libglib2.0-dev \
    libgpgme-dev \
    libgnutls28-dev \
    uuid-dev \
    libssh-gcrypt-dev \
    libhiredis-dev \
    libxml2-dev \
    libpcap-dev \
    libldap2-dev \
    libradcli-dev \
    libnet1-dev

ADD https://github.com/greenbone/gvm-libs/archive/v21.4.0.tar.gz gvm-libs-21.4.0.tar.gz
RUN tar xzf gvm-libs-21.4.0.tar.gz && \
    cd gvm-libs-21.4.0 && \
    cmake . && \
    make install

RUN apt-get update && apt-get install -y \
    libpq-dev \
    postgresql-server-dev-11 \
    pkg-config \
    libical-dev \
    xsltproc

ADD https://github.com/greenbone/gvmd/archive/refs/tags/v21.4.0.tar.gz gvmd-21.4.0.tar.gz
RUN tar xzf gvmd-21.4.0.tar.gz && \
    cd gvmd-21.4.0 && \
    cmake . && \
    make install