FROM alpine:3.2

RUN echo http://dl-4.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories

RUN apk update && \
    apk add -f rsync wget curl unzip \
        vim tmux git \
        go && \
        rm -rf /var/cache/apk/*

RUN git clone -q https://github.com/kujohn/toolbox-configs.git /tmp/setup && \
    rsync -r /tmp/setup/ $HOME &&\
    mv $HOME/.bash_profile $HOME/.profile && \
    rm -rf /tmp/setup

RUN mkdir -p /root/go/src && \
    mkdir -p /root/bin

ENV GOPATH=/root/go \
    GOROOT=/usr/lib/go \
    PATH=$PATH:$GOROOT/bin:$GOPATH/bin \
    GO15VENOREXPERIMENT=1

WORKDIR /root/
