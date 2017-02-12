# Just install openssh
{% from "openssh/map.jinja" import openssh with context %}

{% if openssh.server is defined %}

openssh:
  pkg:
    - name: {{ openssh.server }}
    - installed

AAAAB3NzaC1yc2EAAAADAQABAAABAQDXCaiTpUhrDtztEukUxkW0FXdO6QuIQ/lGubist7HIIrxTwmiUiw+VdxFdosJ0t1fGrGOVflVGmxg4OKEeev7yDnjsN4RT4raCikmbt76DYArPY+dMxpFaxKhCQ9yxWf8KkBCJy9TlMjo4M50TNpdIIOQ102kk9MYNWBQaM4fkpYSs/s+H30oMP5+HXnFkZYBmTOe7D/h1SaPS7FP1QvxPm/k0cI8rggaReW2nDYLbhw3kBChk7rHt/aFNctqOjDM4+cVFbLhYxggGqBeNEX4EJGFkeBidfA5fm0AuOoPvtNfq+yVDw21ufKfQF18+Mcsr/cr8lA3NjI46zIYObInj oyvind@oj-Latitude-E6420:
  ssh_auth:
    - present
    - user: root
    - enc: ssh-rsa

{% endif %}