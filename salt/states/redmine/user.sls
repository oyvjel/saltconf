redmine-user:
  user.present:
    - name : redmine
    - system: True
    - shell: /bin/bash
    - fullname: Redmine
    - home: /home/redmine
    - groups:
      - www-data

git-home:
  file.directory:
    - name: /home/redmine
    - user: redmine
    - group: redmine
    - mode: 750
    - require:
      - user: redmine

redmine-group:
  group.present:
    - name: redmine
    - addusers:
      - www-data
    - require:
      - user: redmine-user
