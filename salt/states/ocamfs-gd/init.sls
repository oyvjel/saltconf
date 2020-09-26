#Formulas to install and set up packages:


{% if grains['os'] == 'Debian' %}
# Debian:
  {% if grains['osmajorrelease'] == 10 %}
    {% set OSCODE = 'xenial' %}
  {% else %}
    {% set OSCODE = 'xenial' %}
  {% endif %}

google-drive-ocamlfuse-repo:
  pkgrepo.managed:
    - humanname: google-drive-ocamlfuse
    - name: deb http://ppa.launchpad.net/alessandro-strada/ppa/ubuntu {{OSCODE}} main
    - file: /etc/apt/sources.list.d/ocamlfuse-alessandro-strada.list
    - clean_file: true
#    - keyid: AD5F235DF639B041
    - keyid: F639B041
    - keyserver: keyserver.ubuntu.com
    - refresh_db: true
{% endif %}

{% if grains['os'] == 'Ubuntu' %}
# Ubuntu:
### Works only for Ubuntu:
google-drive-ocamlfuse-repo:
  pkgrepo.managed:
    - humanname: google-drive-ocamlfuse
    - ppa: alessandro-strada/ppa
    - keyid: F639B041    
    - keyserver: keyserver.ubuntu.com
    - refresh_db: true
{% endif %}

#Packages installed with packagemanager, no extra config:


googlsdrivekgs:
  pkg:
    - installed
    - names:
    - require:
      - pkgrepo: google-drive-ocamlfuse-repo

