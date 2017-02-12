# -*- coding: utf-8 -*-
'''
Regexp extention for jinja
Øyvind Jelstad

Calling:
    {{ salt['oj.replace']( grains['id'], '-dev$', '') }}

'''

# Import python libs
import re

def replace( string, pattern, replacement):
    return re.sub(pattern, replacement, string)
