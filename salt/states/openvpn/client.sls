# ======================================================================
# Openvpn prerequsits & installation
# ØJ, nov 2014
# ======================================================================
{% if pillar['openvpn'] is defined %}

{% set server= salt['pillar.get']('openvpn:server','hoj.jelstad.org') %}
{% set port= salt['pillar.get']('openvpn:port','443') %}
{% set proto= salt['pillar.get']('openvpn:proto','tcp') %}

{% set hid=grains['id']%}

/etc/openvpn:
  file.directory:
    - user: root
    - group: adm
    - mode: 0755

/etc/openvpn/client.conf:
  file.managed:
#    - contents_pillar: openvpn
    - source: salt://openvpn/client.conf
    - template: jinja
    - context:
      id: "{{ hid }}"
      proto: "{{ proto }}"
      port: "{{ port }}"
      server: "{{ server }}"
    - user: root
    - group: root
    - mode: 0644
    - require:
      - file: /etc/openvpn
      - pkg: openvpn

/etc/openvpn/client.up:
  file.managed:
    - source: salt://openvpn/client.up
    - user: root
    - group: root
    - mode: 0744
    - require:
      - file: /etc/openvpn
      - pkg: openvpn

/etc/NetworkManager/system-connections/OpenVPN-{{ server }}:
  file.managed:
#    - contents_pillar: openvpn
    - source: salt://openvpn/OpenVPN-netmgr
    - template: jinja
    - context:
      id: "{{ hid }}"
      server: "{{ server }}"
      proto: "{{ proto }}"
      port: "{{ port }}"
    - user: root
    - group: root
    - mode: 0600
    - require:
      - file: /etc/openvpn
      - pkg: openvpn


/etc/openvpn/ca.crt:
  file.managed:
    - contents_pillar: openvpn:cacrt
    - user: root
    - group: root
    - mode: 0644
    - require:
      - file: /etc/openvpn
      - pkg: openvpn

/etc/openvpn/{{ hid }}.crt:
  file.managed:
    - contents_pillar: openvpn:minioncrt
    - user: root
    - group: root
    - mode: 0644
    - require:
      - file: /etc/openvpn
      - pkg: openvpn


/etc/openvpn/{{ hid }}.key:
  file.managed:
    - contents_pillar: openvpn:minionkey
    - user: root
    - group: root
    - mode: 0644
    - require:
      - file: /etc/openvpn
      - pkg: openvpn

openvpn:
  pkg.installed:
    - pkgs:
      - openvpn
      - network-manager
      - network-manager-openvpn
#      - network-manager-openconnect
#      - network-manager-strongswan
#      - network-manager-vpnc
{% if salt['pillar.get']('vpnautostart') %}
  service.running:
    - enable: True
    - watch:
      - pkg: openvpn
      - file: /etc/openvpn/client.conf
      - file: /etc/openvpn/client.up
      - file: /etc/openvpn/{{ hid }}.crt
      - file: /etc/openvpn/{{ hid }}.key
{% else %}
  service.disabled:
    - name: openvpn

{% endif %}
{% endif %}