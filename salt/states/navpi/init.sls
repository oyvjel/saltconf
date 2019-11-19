#Formulas to install and set up packages:
include:
#  - jed
  - git
# call as: salt-call state.sls  navpi.maps -l debug
#  - navpi.maps
#  - vim

{% set NODEREPO = 'node_12.x' %}

nodejs-repo:
  pkgrepo.managed:
    - humanname: Nodejs repo
    - name: deb https://deb.nodesource.com/{{NODEREPO}} {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/nodesource.list
    - clean_file: true
    - key_url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key

#    - keyserver: keyserver.ubuntu.com

{% if grains['os'] == 'Debian' %}
# Debian:
opencpn-repo:
  pkgrepo.managed:
    - humanname: OpenCPN repo
#    - ppa: opencpn/opencpn
    - name: deb http://ppa.launchpad.net/opencpn/opencpn/ubuntu xenial main
#    - name: deb http://ppa.launchpad.net/opencpn/opencpn/ubuntu {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/opencpn.list
    - clean_file: true
#    - keyid: 67E4A52AC865EB40
    - keyid: C865EB40
    - keyserver: keyserver.ubuntu.com
    - refresh_db: true
{% endif %}

{% if grains['os'] == 'Ubuntu' %}
# Ubuntu:
### Works only for Ubuntu:
opencpn-repo:
  pkgrepo.managed:
    - humanname: OpenCPN repo
    - ppa: opencpn/opencpn
#    - name: deb http://ppa.launchpad.net/opencpn/opencpn/ubuntu bionic main
#    - name: deb http://ppa.launchpad.net/opencpn/opencpn/ubuntu {{ grains['oscodename'] }} main
#    - file: /etc/apt/sources.list.d/opencpn.list
#    - clean_file: true
#    - keyid: 67E4A52AC865EB40
    - keyid: C865EB40
    - keyserver: keyserver.ubuntu.com
    - refresh_db: true
{% endif %}

#Packages installed with packagemanager, no extra config:


nodejs:
  pkg.latest:
     - require:
       - pkgrepo: nodejs-repo

# npm is now in nodejs
#npm: 
#  pkg.latest:
#     - require:
#       - pkgrepo: nodejs-repo
#       - pkg: nodejs

# Should create symlink: ln -s /usr/bin/nodejs /usr/bin/node

navpipkgs:
  pkg:
    - latest
    - names:
      - build-essential
      - curl
      - lxde
      - dialog
      - wpasupplicant
      - dnsmasq
      - libnss-mdns
      - avahi-utils
      - libavahi-compat-libdnssd-dev
#      - devscripts
      - gpsd
      - gpsd-clients
      - socat
      - tightvncserver
      - xrdp
      - xorgxrdp
      - xfonts-base
      - menu
      - gnome-keyring
      - jed
      - opencpn
      - opencpn-plugin-weatherrouting
      - opencpn-plugin-iacfleet
      - opencpn-plugin-draw
      - opencpn-plugin-pypilot
      - opencpn-plugin-polar
      - opencpn-gshhs-full
      - opencpn-plugin-logbookkonni
      - opencpn-plugin-tactics
      - opencpn-tcdata
      - ofc-pi
      - opencpn-doc
#      - cdo
      - zygrib
#      - zygrib-maps
###      - network-manager-gnome
## Bionic fix:     
##      - python-dev
{% if grains['os'] == 'Ubuntu' %}
      - chromium-browser
{% else %}
      - chromium
#      - chromium-l10n
{% endif %}
    - require:
      - pkgrepo: opencpn-repo

removepkgs:
  pkg.removed:
    - names:
      - network-manager-gnome
      - network-manager

hostapd:
  pkg.installed: []
  service.running:
    - enable: True
    - reload: True

/etc/hostapd.conf:
  file.managed:
    - source: salt://navpi/hostapd.conf
    - template: jinja
    - context:
      hwaddr: {{ salt['grains.get']('hwaddr_interfaces:wlan0') }}

/etc/dnsmasq.d/dnsmasq.conf:
  file.managed:
    - source: salt://navpi/dnsmasq.conf

/etc/network/interfaces:
  file.managed:
    - source: salt://navpi/interfaces

{% if grains['os'] == 'Ubuntu' %}
/etc/resolv.conf:
  file.symlink:
      - target: /run/systemd/resolve/stub-resolv.conf
      - force: True
{% endif %}

# if-up/down scripts does not work anymore. Install fw script, but
# rely on iptables-persistent to save, start and update.
# See http://www.microhowto.info/howto/make_the_configuration_of_iptables_persistent_on_debian.html

/etc/network/if-up.d/fw.sh:
  file.managed:
      - source: salt://navpi/fw.sh

iptables-persistent:
  pkg.installed


/usr/local/bin/yrgrib:
  file.managed:
    - source: salt://navpi/yrgrib
    - template: jinja
    - user: oyvind
    - mode: 755

## Have to run sudo npm install -g --unsafe-perm signalk-server
## and sudo signalk-server-setup
## manually??

signalk-server:
  npm.installed:
#  npm.latest: Viker ikke
#     - force_reinstall: true
    - require:
      - pkg: nodejs

signalk-plugins:
  npm.installed:
    - names:
      - signalk-seatalk1-autopilot
      - signalk-switch-automation
      - signalk-windjs
    - require:
      - pkg: nodejs
      - npm: signalk-server

/etc/systemd/system/vncserver@:1.service:
  file.managed:
    - source: salt://navpi/systemd.vncserver
    - template: jinja
    - user: root
    - mode: 644
#    - watch_in:
#      - service: vncserver	    

vncserver@:1:
  service.running:
    - enable: True
    - reload: True

#/home/oyvind/.vnc/passwd:
#  file.managed:
#    - source: salt://navpi/passwd
#    - template: jinja
#    - user: oyvind
#    - mode: 700

/home/oyvind/.vnc/xstartup:
  file.managed:
    - source: salt://navpi/xstartup
    - template: jinja
    - user: oyvind
    - mode: 744

/etc/udev/rules.d/70-persistent-net.rules:
  file.managed:
    - source: salt://navpi/udev.ap
    - template: jinja
    - context:
      hwaddr: 12:42:fc:31:80:8f
#      hwaddr: {{ salt['grains.get']('hwaddr_interfaces:wlan0') }}
    - user: oyvind
    - mode: 744

nb_locale:
  locale.present:
    - name: nb_NO.UTF-8

default_locale:
  locale.system:
    - name: nb_NO.UTF-8
    - require:
      - locale: nb_locale

Europe/Oslo:
  timezone.system:
    - utc: True