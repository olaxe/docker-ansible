FROM python:3-alpine
MAINTAINER "Mansionis"

RUN apk add --update --no-cache \
    openssh-client \
    rsync \
    musl-dev \
    libffi-dev \
    openssl-dev
RUN apk add --update --no-cache \
    --virtual .build-deps \
    make \
    gcc \
    python3-dev \
    && pip install --upgrade pip \
    && pip install --no-cache-dir ansible \
    && apk del .build-deps

WORKDIR /
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["tail", "-f", "/dev/null"]
RUN ["chmod", "+x", "/entrypoint.sh"]
