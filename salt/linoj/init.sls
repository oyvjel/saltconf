#Formulas to install and set up packages:
include:
  - linoj.hostname
#  - linoj.users.oyvind  
#  - linoj.users.hitadmin
  - users
  - openssh
  - network.interfaces
  - network.resolver
  - network.routes
  - network.hosts
  
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
      - realpath
      - screen
      - sudo
      - tmux
      - vim


 
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
