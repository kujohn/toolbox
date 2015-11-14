FROM alpine:latest

RUN echo http://dl-4.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories

RUN apk update && \
    apk add -f wget curl unzip \
        vim tmux git \
        go

RUN git clone -q -b devel/docker http://github.com/kujohn/dotfiles.git /tmp/dotfiles && \
    cp /tmp/dotfiles/.tmux.conf $HOME && \
    cp /tmp/dotfiles/.vimrc $HOME && \
    cp /tmp/dotfiles/.bash_profile $HOME/.profile && \
    rm -rf /tmp/dotfiles

RUN mkdir -p /root/go/src
ENV GOPATH=/root/go \
    GOROOT=/usr/lib/go \
    PATH=$PATH:$GOROOT/bin:$GOPATH/bin \
    GO15VENOREXPERIMENT=1
