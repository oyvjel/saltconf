base:
  '*':
#    - salt.pkgrepo
    - salt.minion
    - roles
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
    - linoj
    
  'kernel:windows':
    - match: grain
    - win

  'kub*':
    - kubernetes

  'munin_node:*':
    - match: pillar
    - munin.node.config

#  'role:linux-development':
#    - match: pillar
#    - linoj.development

#  'I@role:development and G@kernel:Linux':
#    - match: compound
#    - linoj.development

# Roles from grains. Can be set on the minion side.
#  { set roles = salt['pillar.get']('role',[]) eller salt['grains.get']('roles',[])  }
  {% set roles = salt['grains.get']('roles',[]) -%}
  {% for role in roles -%}
  'roles:{{ role }}':
    - match: grain
    - roles.{{ role }}
  {% endfor -%}

# Roles from pillars. 

#  { set roles = salt['pillar.get']('role',[]) eller salt['grains.get']('roles',[])  }
  {% set roles = salt['pillar.get']('role',[]) -%}
  {% for role in roles -%}
  'role:{{ role }}':
    - match: pillar
    - roles.{{ role }}
  {% endfor -%}
  




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
