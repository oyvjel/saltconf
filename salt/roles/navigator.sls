{% if grains['kernel'] == 'Linux' %}
include:
  - opencpn

{% endif %}
