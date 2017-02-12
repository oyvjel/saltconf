redmine:
  use_rvm: False
  rvm_ruby: 2.1.0
#  shell_version: v2.2.0
  redmine_version: 2.6.0
  db_engine: postgresql
  db_name: 'redmine'
  db_user: 'redmine'
  db_pass: 'MyVerySecretPassword'
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
