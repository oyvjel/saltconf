include:
  - user.tester
  - user.oyvind
  
#role:
#  - development
#  - desktop
  
cmdb:
  status: development
  product:
    - itop

network:
  interfaces:
    {# Basic Setup #}
    - name: eth0
      proto: static
      ipaddr: 10.18.101.214
      netmask: 255.255.254.0
      gateway: 10.18.100.1

  resolver:
    domain: embriq.no
    search:
      - hipad.no
      - ncop.net
    nameservers:
      - 172.28.61.10
#    - 2002::beef

  hosts:
    - name: saltdev
      ip: 10.18.101.211
