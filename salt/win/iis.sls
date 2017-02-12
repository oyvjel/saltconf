

# salt mon-test-win2012 win_servermanager.list_available
Web-Server:
  win_servermanager.installed:
    - force: True
#    - recurse: True


{%- for site in salt['pillar.get']('webserver:sites', '') %}

{{ site.name }}:
  win_iis.deployed:
#    - name: site0
#    - sourcepath: {{ site.path }}
    - sourcepath: C:\inetpub\site0
    - require:
      - win_servermanager: Web-Server 

{%- endfor %}
