https://hub.docker.com/r/selenium/hub/

拉取镜像
```
docker pull selenium/hub
docker pull selenium/node-chrome
docker pull selenium/node-firefox
```


注意:

多节点测试时, 程序结束, 驱动需要退出, 否则报错。

```
selenium.common.exceptions.WebDriverException: Message: Failed to decode response from marionette
```
