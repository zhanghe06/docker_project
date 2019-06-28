FROM alpine:3.6
MAINTAINER zh <zhang_he06@163.com>

ADD ./requirements.txt /requirements.txt

RUN apk update && apk add --upgrade --no-cache --virtual .build-dependencies \
    g++ \
    gcc \
    make \
    libxml2-dev \
    libxslt-dev \
    curl \
    tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && pip install -r /requirements.txt \
    && apk del .build-dependencies
