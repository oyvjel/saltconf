# Roles from grains. Can be set on the minion side.
include:
  - all
{% set roles = salt['grains.get']('roles',[]) -%}
{% for role in roles -%}
#  'roles:{{ role }}':
#    - match: grain
  - roles.{{ role }}
{% endfor -%}

# Roles from pillars. 
{% set roles = salt['pillar.get']('role',[]) -%}
{% for role in roles -%}
#  - roles.{{ role }}
{% endfor -%}


rm_roles:
  grains.absent:
    - name: roles:test

# Set corresponding grain on minion from pillar.role[]
# Targeting in top.sls should use the grain roles[] except for config that
# should not be controllable from the minion side.

{% set rl = salt['pillar.get']('role',[]) %}
{% if rl %}
roles:
  grains.present:
    - value:
{% for r in rl %}
      - {{ r }}
{% endfor %}
#      - test
#    - force: True
{% endif %}

