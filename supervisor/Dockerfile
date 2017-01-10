FROM python:2.7.12
MAINTAINER zh "zhanghe@wealink.com"

RUN apt-get update && apt-get install -qy --no-install-recommends \
    build-essential \
    apt-utils \
    python-dev \
    openssh-server \
    vim

#ADD ./requirements.txt /requirements.txt
#RUN pip install -r /requirements.txt

RUN pip install --no-cache-dir \
    supervisor

EXPOSE 9001

WORKDIR /supervisor

#ENTRYPOINT ["supervisord"]
