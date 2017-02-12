# Map host IDs to sets of pillar data:

{% set hostname=grains['id'] %}
{% set hostfile=grains['id']|replace(".","_") %}

base:
#  '*':
#    - user.oyvind
#    - testprod

# Include the individual host-specific pillar-files if they exist:
{% if salt['file.file_exists']('/srv/base/pillar/byid/' + hostfile + '/cmdb.sls') %}
  '{{hostname}}':
    - byid.{{ hostfile }}.cmdb
{% endif %}

{% if salt['file.file_exists']('/srv/base/pillar/byid/' + hostfile + '.sls') %}
  '{{hostname}}':
    - byid.{{ hostfile }}
{% endif %}

#  'nictest':
#    - openvpn
    
#  'gitlab':
  'gitlabformula*':
    - gitlab


#  'saltmaster*':
#    - development

  'w2008*':
    - wintest
    
#include:
#  - cmdb

  'eqos-kvm-01.embriq.no':
    - kvm_nics
    