# curl

[https://hub.docker.com/u/curlimages](https://hub.docker.com/u/curlimages)

[https://hub.docker.com/r/curlimages/curl](https://hub.docker.com/r/curlimages/curl)

```
docker pull curlimages/curl:8.1.2

docker tag curlimages/curl:8.1.2 curl

docker run --rm curl --version

docker run --rm -it -v "$PWD:/work" curl -d@/work/test.txt https://httpbin.org/post
```
