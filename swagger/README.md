# swagger

[https://github.com/swagger-api/swagger-ui](https://github.com/swagger-api/swagger-ui)

```
docker pull swaggerapi/swagger-ui

docker run -p 80:8080 swaggerapi/swagger-ui
docker run -p 80:8080 -e SWAGGER_JSON=/foo/swagger.json -v /bar:/foo swaggerapi/swagger-ui
docker run -p 80:8080 -e BASE_URL=/swagger -e SWAGGER_JSON=/foo/swagger.json -v /bar:/foo swaggerapi/swagger-ui
```

根据配置的BASE_URL，访问对应路径。例如：[http://127.0.0.1/swagger/](http://127.0.0.1/swagger/)
