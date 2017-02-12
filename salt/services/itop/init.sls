# ======================================================================
# itop prerequsits & installation
# ØJ, sept 2014
# ======================================================================

{% set itop = salt['grains.filter_by']({
    'default': {
        'apache': 'httpd',
        'php_soap': 'php5-soap',
	'php_ini': '/etc/php.ini',
	'suhosin_ini': '/etc/php.d/Z98_suhosin.ini',
     },
    'Debian': {
        'apache': 'apache2',
        'php_soap': 'php-soap',
	'php_ini': '/etc/php5/apache2/php.ini',
     },
   },
   default='default' 
   )
%}

# Update the apt.sources to use the latest

itop_prereq:
  pkg.installed:
    - names:
      - {{ itop.apache }}
      - mysql-server
      - php5
      - php5-mysql
      - php5-ldap
      - php5-mcrypt
      - php5-cli
      - {{ itop.php_soap }}
      - php5-json
      - graphviz
      
# Configuration
{{ itop.php_ini }}:
  file.replace:
    - pattern: 'post_max_size = 8M'
    - repl: 'post_max_size = 32M'


itop_install:
  archive:
    - extracted
    - name: /var/www/itop-2.1.0
#    - source: http://sourceforge.net/projects/itop/files/latest/download?source=files
    - source: salt://services/itop/itop-2.1.0.zip
    - archive_format: zip
    - runas: 'www-data'


teemip-install:
  archive:
    - extracted
    - name: /var/www/itop-2.1.0
    - source: salt://services/itop/TeemIp-Module-2.0.2-rc.zip
    - archive_format: zip
    - if_missing: /var/www/itop-2.1.0/web/extensions/teemip-ip-mgmt
    - runas: 'www-data'
    - require:
      - archive: itop_install


/var/www/itop:
  file.symlink:
    - target: /var/www/itop-2.1.0
    - user: www-data
    - group: www-data
    - require:
      - archive: itop_install
      
    
/var/www/itop-2.1.0:
  file:
    - directory
    - user: www-data
    - group: www-data
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
    - require:
      - archive: itop_install
      
#/etc/php.d/Z98_suhosin.ini:
#  file.uncomment:
#    - regex: '^suhosin.get.max_value_length.*'
#    - char: ';'
    
# Firewall
#itop-iptables:
#  cmd.wait_script:
#    - source: salt://service/itop/itop-iptables.sh
#    - watch:
#      - cmd: firewall-lockdown
