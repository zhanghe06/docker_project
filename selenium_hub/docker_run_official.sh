#!/usr/bin/env bash


docker network create grid
docker run -d -p 4444:4444 --net grid --name selenium-hub selenium/hub:3.8.1-erbium
docker run -d --net grid --name selenium-node-chrome -e HUB_HOST=selenium-hub -v /dev/shm:/dev/shm selenium/node-chrome:3.8.1-erbium
docker run -d --net grid --name selenium-node-firefox -e HUB_HOST=selenium-hub -v /dev/shm:/dev/shm selenium/node-firefox:3.8.1-erbium
