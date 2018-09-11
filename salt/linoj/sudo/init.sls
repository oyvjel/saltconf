include:
  - sudo.groups

/etc/sudoers.d:
  file:
    - directory
    - clean: True
#    - require:
#      - file: /etc/sudoers.d/99-python

sudo:
  pkg:
    - latest
    - require:
      - group: sudo
      - file: /etc/sudoers.d
