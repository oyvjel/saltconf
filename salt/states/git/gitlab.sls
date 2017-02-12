gitlab-from-pkg:
  pkg.installed:
    - sources:
      - gitlab: https://downloads-packages.s3.amazonaws.com/debian-7.6/gitlab_7.5.3-omnibus.5.2.1.ci-1_amd64.deb

#/etc/bash.bashrc:
#  file.managed:
#    - source: salt://git/bash.bashrc.jinja
#    - template: jinja
#    - user: root
#    - group: root
#    - mode: 644
