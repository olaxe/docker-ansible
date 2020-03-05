FROM python:3.7-alpine
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
    && pip install --no-cache-dir -r ansible==2.9.6 \
    && apk del .build-deps
    
CMD ['ansible']
