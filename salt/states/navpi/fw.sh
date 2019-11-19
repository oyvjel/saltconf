#! /bin/sh
set -e

# Don't bother to restart sshd when lo is configured.
if [ "$IFACE" = lo ]; then
   exit 0
fi
	
# Only run from ifup.
#if [ "$MODE" != start ]; then
#  exit 0
#fi
		

# Reset all tables and policy.
# Default policy is DENY
    /sbin/iptables -P INPUT ACCEPT
    /sbin/iptables -P FORWARD ACCEPT
    /sbin/iptables -P OUTPUT ACCEPT
    /sbin/iptables -t nat -P PREROUTING ACCEPT
    /sbin/iptables -t nat -P POSTROUTING ACCEPT
    /sbin/iptables -t nat -P OUTPUT ACCEPT
    /sbin/iptables -F
    /sbin/iptables -t nat -F
    /sbin/iptables -X
    /sbin/iptables -t nat -X
  
# Enable forwarding.
    echo "1" > /proc/sys/net/ipv4/ip_forward
    

/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
/sbin/iptables -t nat -A POSTROUTING -o cl0 -j MASQUERADE
/sbin/iptables -A FORWARD -i eth0  -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A FORWARD -i cl0  -m state --state RELATED,ESTABLISHED -j ACCEPT
/sbin/iptables -A FORWARD -i ap0  -j ACCEPT
