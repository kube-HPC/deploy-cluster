#!/bin/bash

source ./config.sh

node elasticdump/node_modules/elasticdump/bin/elasticdump.js --input=dashboard.json --output=$ES/.kibana --type=data
