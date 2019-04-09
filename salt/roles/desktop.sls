{% if grains['kernel'] == 'Linux' %}
include:
  - linoj.desktop

{% endif %}
