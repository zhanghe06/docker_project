# gotenberg

文档转pdf

https://github.com/gotenberg/gotenberg

https://gotenberg.dev/docs

[参数设置](https://gotenberg.dev/docs/routes)


word转pdf
```
curl \
--request POST http://localhost:3030/forms/libreoffice/convert \
--form files=@/path/to/file.docx \
-o my.pdf
```

url转pdf
```
curl \
--request POST http://localhost:3030/forms/chromium/convert/url \
--form url='https://wx.thedoc.cn/wechatweb/#/html2img?id=12131&protocolId=35' \
-o my.pdf
```

url转png
```
curl \
--request POST http://localhost:3030/forms/chromium/screenshot/url \
--form url='https://wx.thedoc.cn/wechatweb/#/html2img?id=12131&protocolId=35' \
-o my.png
```
参考：https://github.com/gotenberg/gotenberg/pull/765

```
curl \
--request POST http://localhost:3030/forms/chromium/screenshot/url \
--form url='http://192.168.0.152:8005/screenshot?token=2f78a36bc04241f18b35fceeabb5e4b6' \
--form width=1080 \
--form height=1920 \
--form optimizeForSpeed=true \
-o my.png
```
