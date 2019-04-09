

# Debian:
{% if grains['os'] == 'Debian' %}

docker-req:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - wget
      - software-properties-common

docker-deb-repo:
  pkgrepo.managed:
    - humanname: Docker CE repo
    - name: deb [arch={{ grains['osarch'] }}] https://download.docker.com/linux/debian {{ grains['oscodename'] }} stable

    - file: /etc/apt/sources.list.d/docker.list
    - clean_file: true
    - key_url: https://download.docker.com/linux/debian/gpg
    - require:
      - pkg: docker-req


docker-deb-remove:
  pkg.removed:
    - pkgs:
      - docker
      - docker-engine
      - docker.io
      - docker-compose
      - libnss-docker

docker:
  pkg.installed:
    - pkgs:
      - docker-ce
#      - docker-compose
#      - libnss-docker
    - require:
      - pkg: docker-deb-remove
      - pkgrepo: docker-deb-repo
  service.running:
    - enable: True
    - watch:
      - pkg: docker



#grub-settings:
#  file.append:
#    - name: /etc/default/grub
#    - text: 'GRUB_CMDLINE_LINUX_DEFAULT="console=ttyS0,9600n8 console=tty0 text nosplash nomodeset nohz=off transparent_hugepage=always"'
#grub-settings2:
#  file.append:
#    - name: /etc/default/grub
#    - text: 'GRUB_CMDLINE_LINUX="console=ttyS0,9600n8 console=tty0 text nosplash nomodeset nohz=off transparent_hugepage=always"'

#update-grub:
#  cmd.run:
#    - name: update-grub
#    - require:
#      - file: grub-settings
#      - file: grub-settings2
{% endif %}
