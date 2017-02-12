
{% if grains['os_family'] == 'Windows' %}
perl-packages:
  pkg.latest:
    - pkgs:
      - strawberryperl_x64



#c:\program files\nsclient++\nsc.ini:
#  file.absent

#c:\program files\nsclient++\nsclient.ini:
#  file.managed:
#    - source: salt://win/nsclient.ini

{% endif %}


