#Formulas to install and set up packages:
include:
  - jed
  - git
  - xrdp
#  - vim

#Packages installed with packagemanager, no extra config:
desktoppkgs:
  pkg.installed:
    - names:
      - vim
      - gnome
      - keepassx
#      - git
#      - ssh

# 60 is default. Desktop could benefit from lower ( 10?). Should be a pillar value.
#vm.swappiness:
#  sysctl.present:
#    - value: 60

