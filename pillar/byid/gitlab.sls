include:
  - gitlab

#role:
#  - development
#  - desktop
  
#cmdb:
#  status: development
#  product:
#    - gitlab
#    - ourwebsite
#    - fileserver

network:
  interfaces:
    {# Basic Setup #}
    - name: eth0
      proto: static
      ipaddr: 10.18.101.212
      netmask: 255.255.254.0
      gateway: 10.18.100.1

  resolver:
    domain: embriq.no
    search:
      - hipad.no
#      - another.local
    nameservers:
      - 172.28.61.10
#    - 2002::beef

  hosts:
    - name: saltdev
      ip: 10.18.101.211
