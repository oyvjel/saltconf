# ======================================================================
# LAMP prerequsits & installation
# ØJ, jan 2015
# ======================================================================

{% set lamp = salt['grains.filter_by']({
    'default': {
        'apache': 'httpd',
        'php_soap': 'php5-soap',
	'php_ini': '/etc/php.ini',
	'suhosin_ini': '/etc/php.d/Z98_suhosin.ini',
	'service': 'httpd',
     },
    'Debian': {
        'apache': 'apache2',
        'php_soap': 'php-soap',
	'php_ini': '/etc/php5/apache2/php.ini',
	'service': 'apache2',
     },
   },
   default='default' 
   )
%}

include:
  - mysql
  - mysql.client

# Update the apt.sources to use the latest

lamp_prereq:
  pkg.installed:
    - names:
      - {{ lamp.apache }}
      - mysql-server
      - php5
      - php5-common
      - php-pear
      - php5-mysql
      - php5-ldap
      - php5-mcrypt
      - php5-cli
      - php5-gmp
      - {{ lamp.php_soap }}
      - php5-json
      - graphviz
#    - require:
#      - pkg: mysql-server
  service.running:
    - name: {{ lamp.service }}
    - enable: True

# The following states are inert by default and can be used by other states to
# trigger a restart or reload as needed.
apache-reload:
  module.wait:
    - name: service.reload
    - m_name: {{ lamp.service }}

apache-restart:
  module.wait:
    - name: service.restart
    - m_name: {{ lamp.service }}
  
# Configuration
{{ lamp.php_ini }}:
  file.replace:
    - pattern: 'post_max_size = 8M'
    - repl: 'post_max_size = 32M'
    - require:
      - pkg: php5
    
{% if grains['os_family']=="Debian" %}
a2enmod rewrite:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/rewrite.load
    - order: 225
    - require:
      - pkg: lamp_prereq
    - watch_in:
      - module: apache-restart
{% endif %}