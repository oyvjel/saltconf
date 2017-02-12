{% from "salt/package-map.jinja" import pkgs with context %}

salt-minion:
  pkg.installed:
    - name: {{ pkgs['salt-minion'] }}
{%- if grains['os_family'] == 'Windows' %}
  file.managed:
    - name: /salt/conf/minion_example
    - template: jinja
    - source: salt://salt/files/minion
{% else %}
  file.managed:
    - name: /etc/salt/minion_example
    - template: jinja
    - source: salt://salt/files/minion
  service.running:
    - enable: True
    - watch:
      - pkg: salt-minion
      - file: salt-minion
{% endif %}