# -*- coding: utf-8 -*-
import scrapy
import json


class IpCnSpider(scrapy.Spider):
    name = "ip_cn"
    allowed_domains = ["ip.cn"]
    start_urls = ['http://ip.cn/']

    def parse(self, response):
        info = response.xpath('//div[@class="well"]//code/text()').extract()
        ip_info = dict(zip(['ip', 'address'], info))
        print json.dumps(ip_info, indent=4, ensure_ascii=False)
        yield ip_info
