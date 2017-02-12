# Just install packages
{% from "ampache/map.jinja" import ampache with context %}

{% if ampache is defined %}

ampache:
  pkg:
    - name: {{ ampache }}
    - installed

{% endif %}
