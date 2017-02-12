#!/bin/bash
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I OUTPUT -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT
