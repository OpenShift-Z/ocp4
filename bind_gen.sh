$TTL 86400
@ IN SOA ns1-name.test.com. admin.test.com. (
                                                2020021813 ;Serial
                                                3600 ;Refresh
                                                1800 ;Retry
                                                604800 ;Expire
                                                86400 ;Minimum TTL
)

;Name Server Information
@ IN NS ns1.test.com.

;IP Address for Name Server
ns1 IN A 

;A Record for the following Host name

haproxy     IN   A   1.1.1.1
bootstrap   IN   A   1.1.1.1
master0     IN   A   1.1.1.1
master1     IN   A   1.1.1.1
master2     IN   A   1.1.1.1
workstation IN   A   1.1.1.1

compute0    IN   A   1.1.1.1
compute1    IN   A   1.1.1.1

etcd-0.ocp-cluster-01  IN   A   1.1.1.1
etcd-1.ocp-cluster-01  IN   A   1.1.1.1
etcd-2.  IN   A   1.1.1.1

;CNAME Record

api.ocp-cluster-01     IN CNAME haproxy.test.com.
api-int.ocp-cluster-01 IN CNAME haproxy.test.com.
*.apps.ocp-cluster-01  IN CNAME haproxy.test.com.

_etcd-server-ssl._tcp.ocp-cluster-01.test.com.  86400 IN   SRV 0   10   2380 etcd-0.ocp-cluster-01.test.com.
_etcd-server-ssl._tcp.ocp-cluster-01.test.com.  86400 IN   SRV 0   10   2380 etcd-1.ocp-cluster-01.test.com.
_etcd-server-ssl._tcp.ocp-cluster-01.test.com.  86400 IN   SRV 0   10   2380 etcd-2.ocp-cluster-01.test.com.
