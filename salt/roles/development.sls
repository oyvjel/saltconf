{% if grains['kernel'] == 'Windoes' %}
include:
  - win.development

{% endif %}

{% if grains['kernel'] == 'Linux' %}
include:
  - linoj.development

{% endif %}
