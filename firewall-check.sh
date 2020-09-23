#!/bin/sh
# This script ensured firewall rules are set correctly
# Author Elton de Souza elton.desouza@ca.ibm.com 
# Contributors: (add your name here if you contributed)
#
# Official Firewall documentation : https://docs.openshift.com/container-platform/4.5/installing/install_config/configuring-firewall.html

if ! command -v nmap &> /dev/null
then
    echo "Please install nmap (dnf install nmap)"
    exit
fi

if ! command -v dig &> /dev/null
then
    echo "Please install dig (dnf install bind-utils)"
    exit
fi

declare -a arr=(
    "registry.redhat.io"
    "quay.io" "sso.redhat.com"
    "cert-api.access.redhat.com"
    "api.access.redhat.com"
    "infogw.api.openshift.com" # unless we disable telemetry
    "https://cloud.redhat.com/api/ingress" # unless we disable telemetry
    "mirror.openshift.com"
    "storage.googleapis.com/openshift-release"
    "quay-registry.s3.amazonaws.com"
    "api.openshift.com"
    "art-rhcos-ci.s3.amazonaws.com"
    "cloud.redhat.com")

## now loop through the above array
for url in "${arr[@]}"
do
    echo -e "\n\nChecking access to $url"
    nmap -sP --max-retries=1 --host-timeout=1500ms $(dig +short $url)
   # or do whatever with individual element of the array
done