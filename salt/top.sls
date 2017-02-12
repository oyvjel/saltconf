base:
  '*':
    - salt.minion
    - all
    - cmdb
    - services
# services/init.sls parse pillar to select services to install. 


#  'saltmaster*':
  'hoj.jelstad.org': 
    - salt.master
    - git

  'openstack.*':
    - states.kvm

    
  'nictest':
    - openvpn.client

#  'gitlab':
#    - git.gitlab

#  'gitlabformula*':
#    - gitlab

  'kernel:Linux':
    - match: grain
    - linux
    
  'kernel:windows':
    - match: grain
    - win

  'role:linux-development':
    - match: pillar
    - linux.development

  'I@role:development and G@kernel:Linux':
    - match: compound
    - linux.development

  'I@role:desktop and G@kernel:Linux':
    - match: compound
    - linux.desktop

  'G@roles:development and G@kernel:Linux':
    - match: compound
    - linux.development

  'G@roles:desktop and G@kernel:Linux':
    - match: compound
    - linux.desktop

  '*-kvm-*':
    - states.kvm

#   Move to product. Specify product itop in pillar for host.
#  'itop*':
#    - services.itop

#dev:
# '*-dev and G@kernel:Linux':
#   - match: compound
#   - linux

# 'I@role:desktop and G@kernel:Linux':
#   - match: compound
#   - linux.desktop

# '*-dev and I@role:monitoring':
#   - match: compound
#   - nagios.server
