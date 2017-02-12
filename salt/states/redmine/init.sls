include:
  - postgresql
  {% if grains['os_family'] == 'RedHat' %}
  - redmine.repos
  {% endif %}
  - redmine.packages
  - redmine.postgresql
  - redmine.user
  - redmine.ruby
  - redmine.redmine

