# 添加curl
FROM alpine as certs
RUN apk update && apk add ca-certificates

FROM busybox:latest
COPY --from=certs /etc/ssl/certs /etc/ssl/certs

WORKDIR /bin

ADD curl-amd64 curl

RUN chmod +x /bin/curl

RUN export PATH=$PATH:/bin/curl

WORKDIR /home

CMD ["/bin/sh"]
