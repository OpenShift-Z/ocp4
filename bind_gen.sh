#!/bin/bash
# This script generate bind config for OpenShift 4.x
#
# Author Elton de Souza elton.desouza@ca.ibm.com 
# Contributors: (add your name here if you contributed)

# Replace with appropriate values 
nameserver="ns1"
domain="test.com"
cluster_name="ocp-cluster-01"

cat > gen.sh <<EOM
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
$nameserver IN A <nameserver-IP-address>

;A Record for the following Host name

haproxy     IN   A   <haproxy-IP-address>
bootstrap   IN   A   <bootstrap-IP-address>
master0     IN   A   <master0-IP-address>
master1     IN   A   <master1-IP-address>
master2     IN   A   <master2-IP-address>
workstation IN   A   <workstation-IP-address>

compute0    IN   A   <compute0-IP-address>
compute1    IN   A   <compute1-IP-address>

etcd-0.$cluster_name  IN   A   <master0-IP-address>
etcd-1.$cluster_name  IN   A   <master1-IP-address>
etcd-2.$clsuter_name  IN   A   <master2-IP-address>

;CNAME Record

api.$cluster_name     IN CNAME haproxy.$domain.
api-int.$cluster_name IN CNAME haproxy.$domain.
*.apps.$cluster_name  IN CNAME haproxy.$domain.

_etcd-server-ssl._tcp.$cluster_name.$domain.  86400 IN   SRV 0   10   2380 etcd-0.$cluster_name.$domain.
_etcd-server-ssl._tcp.$cluster_name.$domain.  86400 IN   SRV 0   10   2380 etcd-1.$cluster_name.$domain.
_etcd-server-ssl._tcp.$cluster_name.$domain.  86400 IN   SRV 0   10   2380 etcd-2.$cluster_name.$domain.
EOM

chmod +x gen.sh
