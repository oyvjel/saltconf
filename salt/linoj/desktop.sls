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
#      - git
#      - ssh

vm.swappiness:
  sysctl.present:
    - value: 10

