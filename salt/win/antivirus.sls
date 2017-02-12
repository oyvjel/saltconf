# Just install ClamWin
ClamWin:
  pkg:
    {% if grains['os'] == 'Gentoo' %}
    - name: net-misc/openssh
    {% endif %}
    - installed