#!/bin/bash

export NODE_TLS_REJECT_UNAUTHORIZED=0
export ES=https://kube:ubadmin@10.32.10.6:6443/api/v1/proxy/namespaces/kube-system/services/elasticsearch:http/

importKibana(){
node elasticdump/node_modules/elasticdump/bin/elasticdump \
--input=kibana.json \
--output=$ES/.kibana \
--type=data
}

exportKibana(){
node elasticdump/node_modules/elasticdump/bin/elasticdump \
--input=$ES/.kibana \
--output=kibana.json \
--type=data
}
