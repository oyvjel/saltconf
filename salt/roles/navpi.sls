{% if grains['kernel'] == 'Linux' %}
include:
  - navpi

{% endif %}
