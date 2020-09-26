#Formulas to install and set up packages:
include:
  - linoj.hostname
#  - linoj.users.oyvind  
#  - linoj.users.hitadmin
  - users
  - openssh
{% if salt['pillar.get']('network') %} 
  - network.interfaces
  - network.resolver
  - network.routes
  - network.hosts
{% endif %}

# Handled in top.sls, pointing to <role>.sls
#{% if salt['pillar.get']('role','prod') == 'development' %}
#  - states.vim
#{% endif %}

#Packages installed with packagemanager, no extra config:
corepkgs:
  pkg:
    - latest
    - names:
      - aptitude
      - byobu
      - htop
#      - realpath # in coreutils
      - coreutils
      - screen
      - sudo
      - tmux
      - vim
#      - webmin
#      - libnet-interface-perl
#      - libnet-netmask-perl
 
/etc/security/limits.d/99-local:
  file:
    - managed
    - source: salt://linoj/limits.conf
    - user: root
    - group: root
    - mode: 644

/usr/local/bin/logout.sh:
  file:
    - managed
    - source: salt://linoj/logout.sh
    - user: root
    - group: root
    - mode: 755

{% if grains['osfinger'] == 'Kali-2020' or grains['osfinger'] == 'Debian-10'%}
# Fix missing path bug ( debian 10?)
# Bug results in salt-call not able to find commands due to su and sudo missing PATH.
# Remote salt * ... is OK.
/etc/login.defs:
  file.line:
      - mode: ensure
      - content: ALWAYS_SET_PATH yes
      - after: ^ENV_PATH\s*PATH=

{% endif %}
