#!/bin/bash

source ./config.sh
source ../../../util

node elasticdump/node_modules/elasticdump/bin/elasticdump.js --input=$ES/.kibana --output=kibana-exported.json --searchBody='{"filter": { "or": [ {"type" : {"value":"search"}}, {"type": {"value": "dashboard"}}, {"type" : {"value":"visualization"}}] }}' --type=data
