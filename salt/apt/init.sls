
# Debian:
{% if grains['os'] == 'Debian' %}

saltstack-deb-repo:
  pkgrepo.managed:
    - humanname: Saltstack repo
#Updated path: https://repo.saltstack.com/apt/debian/[7|8]/[amd64|armhf]/.*
    - name: deb http://repo.saltstack.com/apt/debian/{{ grains['osmajorrelease'] }}/{{ grains['osarch'] }}/latest {{ grains['oscodename'] }} main 

#    - name: deb http://debian.saltstack.com/debian {{ grains['oscodename'] }}-saltstack main 
#    - dist: precise
    - file: /etc/apt/sources.list.d/saltstack.list
    - clean_file: true
    - key_url: https://repo.saltstack.com/apt/debian/{{ grains['osmajorrelease'] }}/{{ grains['osarch'] }}/latest/SALTSTACK-GPG-KEY.pub
      #    - file: /etc/apt/sources.list.d/saltstack-salt-{{ grains['oscodename'] }}.list
#    - keyid: 28B04E4A
#    - keyserver: keyserver.ubuntu.com

#saltstack-repo-key: 
#  cmd: 
#    - run 
#    - name: 'wget -q -O- "https://repo.saltstack.com/apt/debian/8/amd64/latest/SALTSTACK-GPG-KEY.pub" | apt-key add -' 
#    - unless: 'apt-key list | grep joehealy@gmail.com' 
{% endif %}


# Ubuntu:
{% if grains['os'] == 'Ubuntu' and grains['osrelease'] != '16.04' %}

saltstack-deb-repo:
  pkgrepo.managed:
    - humanname: Saltstack repo
#Updated path: https://repo.saltstack.com/apt/ubuntu/[12|14|16].04/amd64/.*
    - name: deb https://repo.saltstack.com/apt/ubuntu/{{ grains['osrelease'] }}/{{ grains['osarch'] }}/latest {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/saltstack.list
    - clean_file: true
    - key_url: https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub
#    - keyid: 28B04E4A
#    - keyserver: keyserver.ubuntu.com

#saltstack-repo-key: 
#  cmd: 
#    - run 
#    - name: 'wget -q -O- "https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub" | apt-key add -'  
#    - unless: 'apt-key list | grep "Launchpad PPA for Salt Stack" '

##    - unless: 'apt-key list | grep saltstack_ubuntu_salt.gpg ' 

### Virker ikke i Ubuntu 15.04 pga manglende ppa.expand_ppa_line i softwareproperties
### se https://github.com/saltstack/salt/pull/17156
#saltstack-ppa:
#  pkgrepo.managed:
#    - ppa: saltstack/salt
#    - refresh_db: true
#    - require:
#      - pkg: software-properties

software-properties:
  pkg.latest:
    - pkgs:
      - software-properties-common
      - python-software-properties

{% endif %}