#!/usr/bin/env python
# encoding: utf-8

"""
@author: zhanghe
@software: PyCharm
@file: __init__.py
@time: 2017/1/12 上午9:20
"""


import os
from logging.config import dictConfig


# BASE_DIR = os.path.abspath(os.path.dirname(__file__)+'/../')


# 日志参数配置
LOG_CONFIG = {
    'version': 1,
    'formatters': {
        'simple': {
            'format': '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        },
        'detail': {
            'format': '%(asctime)s - %(name)s - File: %(filename)s - line: %(lineno)d - %(funcName)s() - %(levelname)s - %(message)s'
        },
    },
    'handlers': {
        'console': {
            'class': 'logging.StreamHandler',
            'formatter': 'simple',
            'level': 'INFO'
        },
        'file_app': {
            'class': 'logging.handlers.TimedRotatingFileHandler',
            'formatter': 'detail',
            'level': 'DEBUG',
            'when': 'D',
            'filename': 'logs/app.log'
        },
        'file_db': {
            'class': 'logging.handlers.TimedRotatingFileHandler',
            'formatter': 'detail',
            'level': 'DEBUG',
            'when': 'D',
            'filename': 'logs/db.log'
        }
    },
    'loggers': {
        'app': {
            'handlers': ['console', 'file_app'],
            'level': 'DEBUG'
        },
        'db': {
            'handlers': ['file_db'],
            'level': 'DEBUG'
        }
    }
}

# 配置日志
dictConfig(LOG_CONFIG)


if __name__ == '__main__':
    pass
