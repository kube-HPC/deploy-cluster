#!/bin/bash

docker build -t fluentd-es:5.5.0.3 .
docker tag fluentd-es:5.5.0.3 private.registry.rms:5000/fluentd-es:5.5.0.3
docker push private.registry.rms:5000/fluentd-es:5.5.0.3
