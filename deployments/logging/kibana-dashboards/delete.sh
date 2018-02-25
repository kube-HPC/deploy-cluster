#!/bin/bash

source ./config.sh

echo
echo 'starting elasticsearch work at '$ES
echo

curl -k --user kube:ubadmin -XDELETE 'https://10.32.10.6:6443/api/v1/proxy/namespaces/kube-system/services/elasticsearch:http/logstash-*'
