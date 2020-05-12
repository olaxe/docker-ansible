FROM ubuntu:lts
MAINTAINER "Mansionis"

ENV SLEEP_TIME=86400
ENV USER="deployment"
ENV PUID=999
ENV PGID=999
ENV SSH_ROOT_KEY_NAME="root@ansible"
ENV ANSIBLE_CONFIG_GIT_URL=""

RUN RUN apt-get -qq -y update && \
    apt-get -qq -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
        python3 \
        openssh-client \
        git \
        rsync \
        dnsutils \
        musl-dev \
        libffi-dev \
        openssl-dev \
        nano \
        python3-pip \
    apt-get -y autoremove && \
    apt-get -y autoclean && \
    rm -rf /var/lib/apt-get/lists/*

RUN pip install --upgrade pip && \
    pip install --no-cache-dir ansible && \
    pip install --no-cache-dir dnspython && \
    pip install --no-cache-dir cryptography && \
    pip install --no-cache-dir hcloud

RUN ln -s /usr/local/bin/python3 /usr/bin/python3

COPY config/ssh_config /etc/ssh/ssh_config

RUN mkdir /root/.ssh
VOLUME /root/.ssh

RUN mkdir /etc/ansible
VOLUME /etc/ansible

WORKDIR /root
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
