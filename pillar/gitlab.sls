# Install from git or package will result in:
# Username: root
# Password: 5iveL!fe 

# See: https://about.gitlab.com/downloads/ and https://gitlab.com/gitlab-org/gitlab-ce/tree/master

gitlab:
  use_rvm: False
  rvm_ruby: 2.1.0
  shell_version: v2.2.0
  gitlab_version: 7-5-stable
  db_engine: postgresql
  db_name: 'gitlabhq_production'
  db_user: 'git'
  db_pass: 'MyVerySecretGitLabPassword'
  gravatar:
    enabled: false
  ldap:
    enabled: false
    host: '_your_ldap_server_'
    base: '_the_base_where_you_search_for_users'
    port: 636
    uid: 'sAMAccountName'
    method: 'ssl' # "ssl" or "plain"
    bind_dn: '_the_full_dn_of_the_user_you_will_bind_with'
    password: '_the_password_of_the_bind_user'
    allow_username_or_email_login: true
  omniauth:
    enabled: false
    allow_single_sign_on: false
    block_auto_created_users: true
  shell:
    audit_usernames: false
    log_level: INFO
    self_signed_cert: false
    #ca_file: /etc/ssl/cert.pem
    {% if grains['os_family'] == 'RedHat' %}
    ca_file: /etc/pki/tls/certs/ca.crt
    {% elif grains['os_family'] == 'Debian' %}
    ca_file: /etc/ssl/certs/ca.crt
    {% endif %}
    #ca_path: /etc/pki/tls/certs
    #{% if grains['os_family'] == 'RedHat' %}
    #ca_path: /etc/pki/tls/certs
    #{% elif grains['os_family'] == 'Debian' %}
    #ca_path: /etc/ssl/certs
    #{% endif %}

  unicorn:
    worker_processes: 2
    timeout: 30
  https: False
  ssl_key: |
    -----BEGIN PRIVATE KEY-----
    ABC=
    -----END PRIVATE KEY-----
  ssl_cert: |
    -----BEGIN CERTIFICATE-----
    ABC=
    -----END CERTIFICATE-----
