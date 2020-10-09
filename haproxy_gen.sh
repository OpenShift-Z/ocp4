listen ingress-http

    bind *:80
    mode tcp

    server worker0 1.1.1.1:80 check
    server worker1 1.1.1.1:80 check

listen ingress-https

    bind *:443
    mode tcp

    server worker0 1.1.1.1:443 check
    server worker1 1.1.1.1:443 check

listen api

    bind *:6443
    mode tcp

    server bootstrap 1.1.1.1:6443 check
    server master0 1.1.1.1:6443 check
    server master1 1.1.1.1:6443 check
    server master2 1.1.1.1:6443 check

listen api-int

    bind *:22623
    mode tcp

    server bootstrap 1.1.1.1:22623 check
    server master0 1.1.1.1:22623 check
    server master1 1.1.1.1:22623 check
    server master2 1.1.1.1:22623 check
