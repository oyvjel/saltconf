#Formulas to install and set up packages:
include:
  - jed
  - git
#  - vim

#Packages installed with packagemanager, no extra config:
developmentpkgs:
  pkg:
    - latest
    - names:
      - build-essential
      - devscripts
      - fakeroot
      - debhelper
      - dconf-tools
      - gconf-editor
      - subversion
      - git-svn
# Eclipse from formula, package version does not work in Ubuntu
#      - eclipse
#      - eclipse-anyedit
#      - eclipse-cdt
#      - eclipse-cdt-autotools
##      - eclipse-cdt-pkg-config
##      - eclipse-gef
##      - eclipse-jdt
      
#      - qemu-kvm-spice
#      - python-spice-client-gtk
#      - libvirt-bin
      - virt-manager
      - virt-viewer
      - ecryptfs-utils
      # TODO: - skype
      - nmap
#      - libghc-xmonad-dev
#      - libghc-xmonad-contrib-dev
      # TODO: clojure & leiningen
#      - openjdk-7-jdk
