
# Only execute if host has correct role:
# Test: sudo salt '*montest*' state.sls roles.poller test=True

{% if 'poller' in pillar.get('role',[]) %}


include:
#  - repos.epel
#  - monitored
  - centreon.poller
  - openssh.config
  
{% endif %}