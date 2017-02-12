include:
  - redmine.ruby

redmine-git:
  git.latest:
    - name: https://github.com/redmine/redmine.git
    - rev: {{ salt['pillar.get']('redmine:redmine_version') }}
    - user: redmine
    - target: /home/redmine/redmine
    - require:
      - user: redmine-user
      - sls: redmine.ruby
#      - pkg: rails
      - pkg: git
#      - pkg: libapache2-mod-passenger
      - pkg: apache2      
#     - cmd: gitlab-shell



apache2:
  pkg:
    - installed
  service.running:
    - enable: True
    - watch:
      - cmd: redmine-migrate-db
      - cmd: redmine-gems
      
apache-restart:
  module.wait:
    - name: service.restart
    - m_name: apache2

libapache2-mod-passenger:
  pkg:
    - installed

#redmine:
#  pkg:
#  - installed

#redmine-sqlite:
#pkg:
#- installed

/var/www/redmine:
  file.symlink:
    - target: /home/redmine/redmine/public
    - require:
      - pkg: apache2
      - git: redmine-git

# Configuration files
/etc/apache2/sites-available/default:
  file.managed:
    - source: salt://redmine/sites-available
    - require:
      - pkg: apache2
      - git: redmine-git

/etc/apache2/mods-available/passenger.conf:
  file.managed:
    - source: salt://redmine/passenger.conf
    - require:
      - pkg: apache2


redmine-config:
  file.managed:
    - name: /home/redmine/redmine/config/configuration.yml
    - source: salt://redmine/configuration.yml
    - template: jinja
    - user: redmine
    - group: redmine
    - mode: 640
    - require:
      - git: redmine-git
      - user: redmine-user

redmine-db-config:
  file.managed:
    - name: /home/redmine/redmine/config/database.yml
    - source: salt://redmine/database.yml
    - template: jinja
    - user: redmine
    - group: redmine
    - mode: 640
    - require:
      - git: redmine-git
      - user: redmine-user

redmine-initialize:
  cmd.wait:
    - user: redmine
    - cwd: /home/redmine/redmine
    - name: rake generate_secret_token
    - shell: /bin/bash
#    - unless: psql -U {{ salt['pillar.get']('redmine:db_user') }} {{ salt['pillar.get']('redmine:db_name') }} -c 'select * from users;'
#    - watch:
#      - git: redmine-git
    - require:
      - cmd: redmine-gems
#      - cmd: redmine-migrate-db
      - postgres_database: redmine-db

#gemfile_lock_absent:
#  file.absent:
#    - name: /home/redmine/redmine/Gemfile.lock
  
# When code changes, trigger upgrade procedure
# Based on https://gitlab.com/gitlab-org/gitlab-ce/blob/master/lib/gitlab/upgrader.rb
redmine-gems:
  cmd.wait:
    - user: redmine
    - cwd: /home/redmine/redmine
    - name: |
        rm -f /home/redmine/redmine/Gemfile.lock
        bundle install --path ~/mygems --without development test  mysql aws
    - shell: /bin/bash
    - stateful: True
    - watch:
      - git: redmine-git
    - require:
#      - file: gemfile_lock_absent
      - file: redmine-db-config
      - file: redmine-config
      - sls: redmine.ruby

redmine-migrate-db:
  cmd.wait:
    - user: redmine
    - cwd: /home/redmine/redmine
    - name: bundle exec rake db:migrate RAILS_ENV=production
    - shell: /bin/bash
    - stateful: True
#   - whatch_in:
#     - module: apache-restart
    - watch:
      - git: redmine-git
    - require:
      - cmd: redmine-gems
      - cmd: redmine-initialize
      - postgres_database: redmine-db



# https://gitlab.com/gitlab-org/gitlab-ce/blob/master/lib/support/logrotate/gitlab
redmine-logwatch:
  file.managed:
    - name: /etc/logrotate.d/redmine
    - source: salt://redmine/redmine-logrotate
    - user: root
    - group: root
    - mode: 644
