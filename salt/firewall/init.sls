{# using .get() and providing a default on the next line is important to avoid a KeyError for hosts that don't include the Pillar ssh.sls file: #}


{% if pillar.get('firewall', {}) %}
/etc/init/firewall.conf:
    file.managed:
#        - context:
#            key_type:  key_type 
        - mode: 644
        - source: salt://firewall/iptables.conf
        - template: jinja

firewall:
  service.running:
    - enable: True

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

{% endif %}