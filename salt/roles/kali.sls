{% if grains['kernel'] == 'Windows' %}
include:
  - win.users.hitadmin
  - win.winconf
  - win.services

{% endif %} # Windows

#############  Linux ##################
{% if grains['kernel'] == 'Linux' %}
include:
#  - firewall
  - git
  - openssh

  
kalipkgs:
  pkg.installed:
    - pkgs:
      - keepassxc
      - spice-vdagent
      - iptraf-ng
#      - emacs
      - jed
#      - openvas
      - gvm

{% set kt = salt['pillar.get']('kalitasks',[]) %}
{% if kt %}
kalitask:
  pkg.installed:
    - pkgs:
{% for t in kt %}
      - {{ t }}
{% endfor %}
{% endif %}

 

{% endif %} # Linux
