#!/bin/bash

source ./config.sh
source ../../../util

echo
echo 'starting elasticsearch work at '$ES
echo

echo -n 'creating kibana template... '
curl -XPUT $ES/_template/kibana_template -d '{
   "template": ".kibana",
    "settings": {
       "index": {
          "number_of_shards": "1",
          "number_of_replicas": "0"
       }
    }
}'
echo
echo_green 'OK.'

echo -n 'creating logstash template... '
curl -XPUT $ES/_template/logstash_template -d '{
    "template": "logstash-*",
    "settings": {
       "index": {
          "number_of_shards": "1",
          "number_of_replicas": "0"
       }
    },
    "mappings": {
        "_default_": {
            "properties": {
               "level": {
                   "type": "string",
                   "index": "not_analyzed"
                 },
                "kubernetes": {
                    "properties": {
                        "container_name": {
                            "type": "string",
                            "index": "not_analyzed"
                        },
                        "namespace_name": {
                            "type": "string",
                            "index": "not_analyzed"
                        },
                        "pod_name": {
                            "type": "string",
                            "index": "not_analyzed"
                        }
                    }
                },
                "meta": {
                    "properties": {
                        "hostName": {
                            "type": "string",
                            "index": "not_analyzed"
                        },
                        "timestamp": {
                          "type": "date"
                        },
                        "type": {
                          "type": "string",
                            "index": "not_analyzed"
                        },
                        "internal": {
                            "properties": {
                                "component": {
                                    "type": "string",
                                    "index": "not_analyzed"
                                },
                                "statistics" : {
                                    "properties" : {
                                        "vid" : {
                                            "type" : "string",
                                            "index": "not_analyzed"
                                        }
                                    }
                                },
                                "videoData": {
                                    "properties": {
                                      "appId": {
                                            "type": "string",
                                            "index": "not_analyzed"
                                        },
                                        "userId": {
                                            "type": "string",
                                            "index": "not_analyzed"
                                        },
                                        "adapterData": {
                                           "properties": {
                                              "externalId": {
                                                "type": "string"
                                              }
                                    	   }
                                        },
                                        "title": {
                                            "type": "string",
                                            "index": "not_analyzed"
                                        },
                                        "vid": {
                                            "type": "string",
                                            "index": "not_analyzed"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}'
echo
echo_green 'OK.'


if [[ "$1" == "-c" ]]; then
  echo -n 'deleting logstash-* index... '
  curl -XDELETE $ES/logstash-*
  echo
  echo_green 'OK.'

  echo -n 'deleting .kibana index... '
  curl -XDELETE $ES/.kibana
  echo
  echo_green 'OK.'

fi

echo -n 'importing dashboards... '
echo
node elasticdump/node_modules/elasticdump/bin/elasticdump.js --input=dashboard.json --output=$ES/.kibana --type=data
echo
echo_green 'OK.'
