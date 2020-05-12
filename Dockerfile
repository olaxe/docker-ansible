FROM ubuntu
MAINTAINER "Mansionis"

ENV SLEEP_TIME=86400
ENV USER="deployment"
ENV PUID=999
ENV PGID=999
ENV SSH_ROOT_KEY_NAME="root@ansible"
ENV ANSIBLE_CONFIG_GIT_URL=""

ENV DEBIAN_FRONTEND=noninteractive

RUN apt -qq -y update && \
    apt -qq -y upgrade && \
    apt -qq -y install \
        locales \
        python3 \
        openssh-client \
        git \
        rsync \
        dnsutils \
        musl-dev \
        libffi-dev \
        #openssl-dev \
        nano \
        python3-pip && \
    apt -qq -y autoremove && \
    apt -qq -y autoclean && \
    rm -rf /var/lib/apt-get/lists/*

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir ansible && \
    pip3 install --no-cache-dir dnspython && \
    pip3 install --no-cache-dir cryptography && \
    pip3 install --no-cache-dir hcloud

COPY config/ssh_config /etc/ssh/ssh_config

RUN mkdir /root/.ssh
VOLUME /root/.ssh

RUN mkdir /etc/ansible
VOLUME /etc/ansible

WORKDIR /root
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
