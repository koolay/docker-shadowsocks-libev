FROM alpine:3.6

LABEL maintainer streeven

ENV SHADOWSOCKS_VERSION v3.1.0

RUN set -ex \
 && BUILD_DIR='/build' \
 && apk add --no-cache \
        libcrypto1.0 \
        libev \
        libsodium \
        mbedtls \
        pcre \
        udns \
 && apk add --no-cache --virtual BUILD_DEPS \
        autoconf \
        automake \
        build-base \
        curl \
        gettext-dev \
        git \
        libev-dev \
        libsodium-dev \
        libtool \
        linux-headers \
        mbedtls-dev \
        openssl-dev \
        pcre-dev \
        tar \
        udns-dev \
 && git clone --recursive https://github.com/shadowsocks/shadowsocks-libev $BUILD_DIR \
 && cd $BUILD_DIR \
 && git checkout -b specific_version $SHADOWSOCKS_VERSION \
    && ./autogen.sh \
    && ./configure --disable-documentation \
    && make install \
 && cd .. \
 && rm -rf $BUILD_DIR \
 && apk del BUILD_DEPS

EXPOSE 8388/tcp
EXPOSE 8388/udp
