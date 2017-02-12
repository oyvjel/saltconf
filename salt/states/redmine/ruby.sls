
redmine-ruby:
{% if salt['pillar.get']('redmine:use_rvm', false) %}
  rvm.installed:
    - name: ruby-{{ salt['pillar.get']('redmine:rvm_ruby', '2.1.0') }}
    - default: True
    - user: git
    - require:
      - user: redmine-user
      - pkg: rvm-deps
  gem.installed:
    - user: redmine
    - ruby: ruby-2.1.0
    - require:
      - rvm: redmine-ruby
{% else %}
  {% if grains['os_family'] == 'Debian' %}
  pkg.installed:
    - pkgs:
      - ruby
      - ruby-dev
      - rails3
      - rake
  gem.installed:
    - name: bundler
    - require:
      - pkg: redmine-ruby
  {% elif grains['os_family'] == 'RedHat' %}
  pkg.installed:
    - pkgs:
      - ruby193-ruby
      - ruby193-ruby-devel
      - ruby193-rubygem-bundler
  {% endif %}
{% endif %}
