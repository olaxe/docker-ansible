FROM python:3-alpine
MAINTAINER "Mansionis"

ENV SLEEP_TIME=86400
ENV USER="deployment"
ENV PUID=999
ENV PGID=999
ENV SSH_ROOT_KEY_NAME="root@ansible"
ENV ANSIBLE_CONFIG_GIT_URL=""

RUN apk --no-cache update && apk --no-cache upgrade
RUN apk add --no-cache openssh-client
RUN apk add --no-cache git
RUN apk add --no-cache rsync
RUN apk add --no-cache musl-dev
RUN apk add --no-cache musl-dev
RUN apk add --no-cache libffi-dev
RUN apk add --no-cache openssl-dev

RUN apk add --update --no-cache \
    --virtual .build-deps \
    make \
    gcc \
    python3-dev \
    && pip install --upgrade pip \
    && pip install --no-cache-dir ansible \
    && pip install dnspython
    && apk del .build-deps

RUN mkdir /root/.ssh
VOLUME /root/.ssh

RUN mkdir /etc/ansible
VOLUME /etc/ansible

WORKDIR /root
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
