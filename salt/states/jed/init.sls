jed-packages:
  pkg.installed:
    - pkgs:
      - jed


/etc/jed.d/10oj.sl:
  file.managed:
    - source: salt://jed/10oj.sl
    - template: jinja
    - user: root
    - group: root
    - mode: 644
