include:
#  - win.users.oyvind
  - win.winconf
{% if salt['pillar.get']('role','prod') == 'development' %}
  - win.antivirus
  - win.development
{% endif %}
{% if salt['pillar.get']('network') %}    
  - network.interfaces
#  - network.resolver
#  - network.routes
#  - network.hosts
{% endif %}
#{% if salt['pillar.get']('role','prod') == 'monitored' %}
#  - win.development
  - monitored

#{% endif %}
