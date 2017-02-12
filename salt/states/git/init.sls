git:
  pkg.installed:
    - pkgs:
      - git
      - gitk

/etc/bash.bashrc:
  file.managed:
    - source: salt://git/bash.bashrc.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
