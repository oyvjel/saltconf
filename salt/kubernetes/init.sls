
# machine ID shold be removed from cloned VMs and regenerated here.
# sudo rm /etc/machine-id
# sudo rm /var/lib/dbus/machine-id
machine_id:
  cmd.run: 
    - name: dbus-uuidgen --ensure=/etc/machine-id
    - unless: test -f /etc/machine_id


# Also SSH-keys:
# /bin/rm -v /etc/ssh/ssh_host_*
# dpkg-reconfigure openssh-server

generate_ssh_keys:
 cmd.run:
   - name: dpkg-reconfigure openssh-server
   - unless: test -f /etc/ssh/ssh_host_rsa_key


debian-packages:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - curl
      - dnsutils
      - net-tools
      - gnupg
      - iptables
      - arptables
      - ebtables
      - docker.io

iptables:
  alternatives.set:
    - path: /usr/sbin/iptables-legacy
    - require:
       - pkg: debian-packages

# and arptables, ebtables?

kub-deb-repo:
  pkgrepo.managed:
    - humanname: Kubernetes repo
    - name: deb https://apt.kubernetes.io/ kubernetes-xenial main
    - file: /etc/apt/sources.list.d/kubernetes.list
    - clean_file: true
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
    - require:
       - pkg: debian-packages
   

# Should be same version on all nodes. Specify version?
kub-packages:
  pkg.installed:
    - pkgs:
      - kubelet
      - kubeadm
      - kubectl
    - require:
      - pkgrepo: kub-deb-repo
       
