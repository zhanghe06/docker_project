#!/usr/bin/env bash

NSQ_NET=192.168.64.217

print "/info"
curl -s http://${NSQ_NET}:4151/info

print "\n/stats"
curl -s http://${NSQ_NET}:4151/stats
