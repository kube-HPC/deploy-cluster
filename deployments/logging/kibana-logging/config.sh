#!/bin/bash

source ../../../config

ES_NAMESPACE=kube-system

export ES=http://${API_SERVER}:8080/api/v1/proxy/namespaces/${ES_NAMESPACE}/services/elasticsearch
