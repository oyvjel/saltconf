{% if grains['kernel'] == 'Windows' %}
include:
  - win.users.hitadmin
  - win.winconf
  - win.services


corepkgs:
  pkg.installed:
    - pkgs:
      - nsclient
      - putty
      - firefox
#      - filezilla
      - ccleaner
      - winscp
      - git
# Finnes ikke:     - powershell
#      - tortoise-git
#      - ssh

{% endif %} # Windows

#############  Linux ##################
{% if grains['kernel'] == 'Linux' %}
include:
  - firewall
  - git
# snmp fra formula.(backend) Config in pillars, see https://github.com/saltstack-formulas/snmp-formula/blob/master/pillar.example
  - snmp
{% if  salt['pillar.get']('snmp') %}
  - snmp.conf
{% endif %}

  
basicserverpkgs:
  pkg.installed:
    - pkgs:
      - iptraf
      - emacs
{% if grains['os_family'] == 'Debian' %}
      - atop
      - ncdu
      - dnsutils
      - yaml-mode
      - emacs-goodies-el
      - php-elisp
      - iftop
      - nload
      - speedometer
      - tig
{% endif %} # Debian

{% endif %} # Linux
