#Formulas to install and set up packages:
#include:
# call as: salt-call state.sls  opencpn.maps -l debug
#  - opencpn.maps



{% if grains['os'] == 'Debian' %}
# Debian:
  {% if grains['osmajorrelease'] == 10 %}
    {% set OSCODE = 'bionic' %}
  {% else %}
    {% set OSCODE = 'xenial' %}
  {% endif %}

opencpn-repo:
  pkgrepo.managed:
    - humanname: OpenCPN repo
#    - ppa: opencpn/opencpn
#    - name: deb http://ppa.launchpad.net/opencpn/opencpn/ubuntu xenial main
    - name: deb http://ppa.launchpad.net/opencpn/opencpn/ubuntu {{OSCODE}} main
    - file: /etc/apt/sources.list.d/opencpn.list
    - clean_file: true
#    - keyid: 67E4A52AC865EB40
    - keyid: C865EB40
    - keyserver: keyserver.ubuntu.com
    - refresh_db: true
{% endif %}

{% if grains['os'] == 'Ubuntu' %}
# Ubuntu:
### Works only for Ubuntu:
opencpn-repo:
  pkgrepo.managed:
    - humanname: OpenCPN repo
    - ppa: opencpn/opencpn
#    - keyid: 67E4A52AC865EB40
    - keyid: C865EB40
    - keyserver: keyserver.ubuntu.com
    - refresh_db: true
{% endif %}

#Packages installed with packagemanager, no extra config:


navpipkgs:
  pkg:
    - latest
    - names:
      - opencpn
      - opencpn-plugin-weatherrouting
      - opencpn-plugin-iacfleet
      - opencpn-plugin-draw
      - opencpn-plugin-pypilot
      - opencpn-plugin-polar
      - opencpn-gshhs-full
      - opencpn-plugin-logbookkonni
      - opencpn-plugin-tactics
      - opencpn-tcdata
      - opencpn-doc
#      - cdo
      - zygrib
#      - zygrib-maps
    - require:
      - pkgrepo: opencpn-repo

