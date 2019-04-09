#Felles konfig, alle maskiner

# Fix systemd BUG: not creating /run/* on boot. Downgrade until fix.
{% if grains['os'] == 'Ubuntu' and grains['osarch'] == 'armhf' and grains['osrelease'] == '16.04' %}


systemd-BUGFIX:
  pkg.installed:
## virker ikke    - version: 229-4ubuntu4
    - pkgs:
      - libpam-systemd: 229-4ubuntu4
      - libsystemd0: 229-4ubuntu4
      - systemd: 229-4ubuntu4
      - systemd-sysv: 229-4ubuntu4

{% endif %}