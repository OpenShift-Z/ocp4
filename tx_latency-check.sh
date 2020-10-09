#!/bin/sh
# This script checks for disk throughput and latency and network throughput and latency
# Author Elton de Souza elton.desouza@ca.ibm.com
# Contributors: (add your name here if you contributed)
#

# Throughput : tx/sec
dd if=/dev/zero of=/tmp/test1.img bs=1G count=1 oflag=dsync

# Latency : tx/sec 
dd if=/dev/zero of=/tmp/test2.img bs=512 count=10000 oflag=dsync

# A massive difference in the results might be an issue (latency issue)