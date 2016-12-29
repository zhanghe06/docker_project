FROM python:2.7.12
MAINTAINER zh "zhanghe@wealink.com"

RUN apt-get update && apt-get install -qy --no-install-recommends \
    build-essential \
    apt-utils \
    python-dev \
    openssh-server \
    libmariadbd-dev \
    vim

#ADD ./requirements.txt /requirements.txt
#RUN pip install -r /requirements.txt

RUN pip install --no-cache-dir \
    Scrapy \
    scrapyd-client \
    MySQL-python \
    SQLAlchemy \
    sqlacodegen

RUN wget https://github.com/scrapy/scrapyd/archive/master.zip -O scrapyd.master.zip \
    && pip install scrapyd.master.zip \
    && rm -rf scrapyd.master.zip

ENV PYTHONPATH /scrapy_project/app

EXPOSE 6800

WORKDIR /scrapy_project/app
#ENTRYPOINT ["/usr/local/bin/scrapyd"]
