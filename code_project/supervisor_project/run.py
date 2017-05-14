#!/usr/bin/env python
# encoding: utf-8

"""
@author: zhanghe
@software: PyCharm
@file: run.py
@time: 2017/1/12 上午9:19
"""


import logging
import time


logger = logging.getLogger('app')


def run():
    logger.info('run time: %s' % time.time())


if __name__ == '__main__':
    run()
