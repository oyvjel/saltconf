# Require pillar 'postfix' to be defined.
# Relies on postfix-formula in masters (gitfs) backend.

{% if  salt['pillar.get']('postfix') %}

include:
  - postfix.config

{% endif %}
