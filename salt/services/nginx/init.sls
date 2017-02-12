# ======================================================================
# Chosen for its simple, lightweight, and scalable capabilities.
# The fact that it ate Apache's lunch didn't hurt either. ;)
# ======================================================================

# Update the apt.sources to use the latest

nginx:
  pkg:
    - installed

# Configuration


# Firewall
nginx-iptables:
  cmd.wait_script:
    - source: salt://service/nginx/nginx-iptables.sh
    - watch:
      - cmd: firewall-lockdown

# Backup configs
  # Need config file setup here
  # Directories for backup
    # /usr/share/nginx/www
