#!/bin/bash

source ./config.sh

echo
echo 'starting elasticsearch work at '$ES
echo
echo -n 'importing dashboards... '
echo
importKibana
echo
echo_green 'OK.'
