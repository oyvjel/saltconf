# Install net-Packages provided by pillar.sls


{% if salt['pillar.get']('cmdb:product') %}
include:
{% for pkg in salt['pillar.get']('cmdb:product', []) %}
  - products.{{ pkg }}
{% endfor %}


##### Log actions on each minion in /root/saltdoc/installed_products.rs
## TODO: Windows file ??

### Virker ikke, faar ikke opprettet fila????
/root/saltdoc/installed_products.rst:
  file.managed:
    - makedirs: True
    
installed_products:
  file.blockreplace:
    - name: /root/saltdoc/installed_products.rst
    - marker_start: "# BLOCK TOP : salt managed zone : please do not edit"
    - marker_end: "# BLOCK BOTTOM : central : end of salt managed zone --"
    - show_changes: True
    - append_if_not_found: True
#    - require_in:
#      - file: /root/saltdoc/installed_products.rst

#- file: chk_products_file

installed-products-cmdb:
  file.accumulated:
    - filename: /root/saltdoc/installed_products.rst
    - text:
{% for pkg in salt['pillar.get']('cmdb:product', []) %}
      - {{ pkg }}
{% endfor %}
    - require_in:
      - file: installed_products

{% endif %}
