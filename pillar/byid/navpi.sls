include:
  - user.oyvind
  
role:
  - navpi
#  - development
#  - desktop

 
munin_node:
  log_level: 4
  log_file: "/var/log/munin/munin-node.log"
  pid_file: "/var/run/munin/munin-node.pid"
  background: 1
  setsid: 1
  user: root
  group: root
  ignore_file:
    - "[\\#~]$"
    - "DEADJOE$"
    - "\\.bak$"
    - "%$"
    - "\\.dpkg-(tmp|new|old|dist)$"
    - "\\.rpm(save|new)$"
    - "\\.pod$"
#  host_name: {{ grains['host'] }}
  allow:
    - "^127\\.0\\.0\\.1$"
    - "^::1$"
    - "^192\\.168\\.220\\.1$"
    - "^192\\.168\\.10\\.10$"
  host: "*"
  port: 4949
