#!bash.sh

#allow input trafic from LAN
iptables -A INPUT -s 10.0.20.0/24 -j ACCEPT

#allow input SSH from WAN
iptables -I INPUT 2 -s 10.44.0.0/24 -d 10.44.0.30 -p TCP --dport 22 -j ACCEPT

#allow loopback traffic
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#allow output traffic
iptables -A OUTPUT -j ACCEPT

#allow established, related trafic
iptables -A INPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p all -m state --state ESTABLISHED,RELATED -j ACCEPT

#disalow all another traffic
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#record rules
/sbin/iptables-save  > /etc/sysconfig/iptables
