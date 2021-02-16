# Deploy-Cluster

## prerequistes
1.  - install ansible on deployer
2.  - create inventory.${env} for the cluster.
3.  - set var file system tu 200g at leats an all serveres
4.  - create user ubadmin
5.  - set swapp to 0
6.  - handle ssh between deployer and k8s cluster nodes
7.  - install tools -  ntp, nfs, netaddr, kubectl, docker
```
  
## Deploy cluster - currently via kubespray


1.  - install ansible on deployer
    sudo apt update
    sudo apt upgrade
    sudo apt install ansible
    sudo dpkg -i ansible_2.9.17-ippa~bionic_all.deb (on premise)
    
2.  -  create inventory.${env} for the cluster. 

---
[all]
ip-172-22-1-207.eu-west-1.compute.internal ansible_ssh_host=172.22.1.207 # m1
ip-172-22-1-110.eu-west-1.compute.internal ansible_ssh_host=172.22.1.110 # m3
ip-172-22-1-175.eu-west-1.compute.internal ansible_ssh_host=172.22.1.175 # m3
ip-172-22-1-119.eu-west-1.compute.internal ansible_ssh_host=172.22.1.119 # w1
ip-172-22-1-85.eu-west-1.compute.internal ansible_ssh_host=172.22.1.85  # w2 
ip-172-22-1-153.eu-west-1.compute.internal ansible_ssh_host=172.22.1.153 # w3
ip-172-22-1-45.eu-west-1.compute.internal ansible_ssh_host=172.22.1.45  # w4
#ip-172-22-1-221.eu-west-1.compute.internal ansible_ssh_host=172.22.1.221 # gp1

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=/home/ubadmin/AWS/HKube/hkube-io.pem
ansible_user=ubuntu
bootstrap_os=ubuntu
kubelet_cgroup_driver="cgroupfs"
supplementary_addresses_in_ssl_keys=54.229.7.145
loadbalancer_apiserver_localhost=true
cluster_name=test

[kube-master]
ip-172-22-1-207.eu-west-1.compute.internal
ip-172-22-1-110.eu-west-1.compute.internal
ip-172-22-1-175.eu-west-1.compute.internal

[etcd]
ip-172-22-1-207.eu-west-1.compute.internal
ip-172-22-1-110.eu-west-1.compute.internal
ip-172-22-1-175.eu-west-1.compute.internal

[kube-node]
ip-172-22-1-207.eu-west-1.compute.internal
ip-172-22-1-110.eu-west-1.compute.internal
ip-172-22-1-175.eu-west-1.compute.internal
ip-172-22-1-119.eu-west-1.compute.internal
ip-172-22-1-85.eu-west-1.compute.internal 
ip-172-22-1-153.eu-west-1.compute.internal
ip-172-22-1-45.eu-west-1.compute.internal
#ip-172-22-1-221.eu-west-1.compute.internal
[gpu]
#ip-172-22-1-221.eu-west-1.compute.internal

[spots]

[k8s-cluster:children]
kube-node
kube-master
--- 


3,4.   set var file system tu 200g at leats an all serveres  and create user ubadmin 
       ansible-playbook  -i   ../env/inventory.${env} ../playbooks/sys_setup.yaml

5. set swapp to 0 
   ansible -i  ../env/inventory.${env} all -m shell -a "sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab"
   ansible -i  ../env/inventory.${env} all -m shell -a "swapoff -a"

6. Handle ssh
    ansible-playbook  -i   ../env/inventory.${env}  ../playbooks/nodes-ssh-copy-id.yml

7.  install tools -  ntp, nfs, netaddr, kubectl, docker
    ansible-playbook  -i   ../env/inventory.${env}  ../playbooks/pre-install.yml

Deploy kubernetes cluster - currently via kubespray
   cd ./deploy-cluster/scripts
   Start-Cluster ${env} 


