include:
  - user.oyvind
#  - user.tester
#  - cmdbuild
  
#role:
#  - development
#  - desktop

network:
  interfaces:
    {# Basic Setup #}
    - name: ens3
      proto: static
      ipaddr: 192.168.10.12
      netmask: 255.255.255.0
      gateway: 192.168.10.1

  resolver:
    domain: jelstad.org
    search:
      - lan
      - jelstad.org
    nameservers:
      - 192.168.10.10
#    - 2002::beef

  hosts:
    - name: salt
      ip: 192.168.10.10
