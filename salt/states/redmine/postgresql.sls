include:
  - postgresql

redmine-db:
  postgres_user.present:
    - name: {{ salt['pillar.get']('redmine:db_user') }}
    - password: {{ salt['pillar.get']('redmine:db_pass') }}
    - require:
      - pkg: install-postgresql
      - service: run-postgresql
  postgres_database.present:
    - name: {{ salt['pillar.get']('redmine:db_name') }}
    - owner: {{ salt['pillar.get']('redmine:db_user') }}
    - template: template0
    - encoding: UTF8
    - require:
      - pkg: install-postgresql
      - service: run-postgresql
      - postgres_user: redmine-db
#      - file: redmine-service

redmine-db-dev:   
  postgres_database.present:
    - name: {{ salt['pillar.get']('redmine:db_name') }}_development
    - owner: {{ salt['pillar.get']('redmine:db_user') }}
    - template: template0
    - encoding: UTF8
    - require:
      - pkg: install-postgresql
      - service: run-postgresql
      - postgres_user: redmine-db
#      - file: redmine-service

redmine-db-test:   
  postgres_database.present:
    - name: {{ salt['pillar.get']('redmine:db_name') }}_test
    - owner: {{ salt['pillar.get']('redmine:db_user') }}
    - template: template0
    - encoding: UTF8
    - require:
      - pkg: install-postgresql
      - service: run-postgresql
      - postgres_user: redmine-db
#      - file: redmine-service
