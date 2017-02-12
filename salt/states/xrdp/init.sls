xrdp-packages:
  pkg.installed:
    - pkgs:
      - xrdp


/etc/xrdp/km-0414.ini:
  file.managed:
    - source: salt://xrdp/km-0414.ini
    - template: jinja
    - user: root
    - group: root
    - mode: 644
