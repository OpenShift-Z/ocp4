#!/bin/bash
# This script generate bind config for OpenShift 4.x
#
# Author Elton de Souza elton.desouza@ca.ibm.com 
# Contributors: (add your name here if you contributed)

# Replace with appropriate values 
nameserver="ns1"
domain="test.com"
cluster_name="ocp-cluster-01"

haproxy_IP_address="1.1.1.1"
bootstrap_IP_address="1.1.1.1"
master0_IP_address="1.1.1.1"
master1_IP_address="1.1.1.1"
master2_IP_address="1.1.1.1"
workstation_IP_address="1.1.1.1"
compute0_IP_address="1.1.1.1"
compute1_IP_address="1.1.1.1"

cat > bind.cfg <<EOM
\$TTL 86400
@ IN SOA $nameserver-name.$domain. admin.$domain. (
                                                2020021813 ;Serial
                                                3600 ;Refresh
                                                1800 ;Retry
                                                604800 ;Expire
                                                86400 ;Minimum TTL
)

;Name Server Information
@ IN NS $nameserver.$domain.

;IP Address for Name Server
$nameserver IN A $nameserver_IP_address

;A Record for the following Host name

haproxy     IN   A   $haproxy_IP_address
bootstrap   IN   A   $bootstrap_IP_address
master0     IN   A   $master0_IP_address
master1     IN   A   $master1_IP_address
master2     IN   A   $master2_IP_address
workstation IN   A   $workstation_IP_address

compute0    IN   A   $compute0_IP_address
compute1    IN   A   $compute1_IP_address

etcd-0.$cluster_name  IN   A   $master0_IP_address
etcd-1.$cluster_name  IN   A   $master1_IP_address
etcd-2.$clsuter_name  IN   A   $master2_IP_address

;CNAME Record

api.$cluster_name     IN CNAME haproxy.$domain.
api-int.$cluster_name IN CNAME haproxy.$domain.
*.apps.$cluster_name  IN CNAME haproxy.$domain.

_etcd-server-ssl._tcp.$cluster_name.$domain.  86400 IN   SRV 0   10   2380 etcd-0.$cluster_name.$domain.
_etcd-server-ssl._tcp.$cluster_name.$domain.  86400 IN   SRV 0   10   2380 etcd-1.$cluster_name.$domain.
_etcd-server-ssl._tcp.$cluster_name.$domain.  86400 IN   SRV 0   10   2380 etcd-2.$cluster_name.$domain.
EOM

cat > haproxy.cfg <<EOM
listen ingress-http

    bind *:80
    mode tcp

    server worker0 $compute0_IP_address:80 check
    server worker1 $compute1_IP_address:80 check

listen ingress-https

    bind *:443
    mode tcp

    server worker0 $compute0_IP_address:443 check
    server worker1 $compute1_IP_address:443 check

listen api

    bind *:6443
    mode tcp

    server bootstrap $bootstrap_IP_address:6443 check
    server master0 $master0_IP_address:6443 check
    server master1 $master1_IP_address:6443 check
    server master2 $master2_IP_address:6443 check

listen api-int

    bind *:22623
    mode tcp

    server bootstrap $bootstrap_IP_address:22623 check
    server master0 $master0_IP_address:22623 check
    server master1 $master1_IP_address:22623 check
    server master2 $master2_IP_address:22623 check
EOM

chmod +x bind.cfg
chmod +x haproxy.cfg

echo "Copy or merge bind.cfg to the appropriate under in /var/named/xxx"
echo "Copy or merge haproxy.cfg to /etc/haproxy/haproxy.cfg"
