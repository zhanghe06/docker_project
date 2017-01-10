#!/usr/bin/env bash

docker run \
        --name scrapyd \
        -v `pwd`/../code_project/scrapy_project:/scrapy_project \
        -d \
        -p 6800:6800 \
        scrapyd \
        /usr/local/bin/scrapyd
