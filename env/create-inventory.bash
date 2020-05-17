#!/bin/bash
env_name=$1
echo "[all]" > inventory.${env_name}
aws ec2 describe-instances     --filter Name=tag-key,Values=Name     --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Instances:LaunchTime,Instances:PrivateDnsName,Name:Tags[?Key==`Name`]|[0].Value}'     --output table  |grep dev |awk -F  "|" '{print  $4}' >> inventory.${env_name}

echo kiki 
exit
[all]

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=/home/ubadmin/AWS/HKube/hkube-io.pem
ansible_user=ubuntu
bootstrap_os=ubuntu
supplementary_addresses_in_ssl_keys=54.229.7.145
loadbalancer_apiserver_localhost=true
cluster_name=test

[kube-master]

[kube-node]

[gpu]

[k8s-cluster:children]
kube-node
kube-master
