#Formulas to install and set up packages:

include:
  - all
#  - services.???
#  - linux.users.oyvind  
#  - linux.users.hitadmin
#  - openssh
# Handled in top.sls, pointing to <role>.sls
#  { % if salt['pillar.get']('role','prod') == 'development' %}

# Pillar based: Install service (states with packages and config) if correspondig pillar
# is defined. 
# Thus, a service can be specified for a host by defining proper pillars, possibly on a per host basis.
# Only hosts to implement a service should have the key pillar defined.

#### Redmine  #######
# State locally defined.
{% if salt['pillar.get']('redmine') %}
  - redmine
{% endif %}

#### Gitlab #######
# State from formula.
{% if salt['pillar.get']('gitlab') %}
  - gitlab
{% endif %}

#### Postgres #######
# State from formula.
{% if salt['pillar.get']('postgres') %}
  - postgres
{% endif %}

