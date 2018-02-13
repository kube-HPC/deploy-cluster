# Deploy-Cluster

## prerequiste
- install ansible 
```
sudo apt-add-repository ppa:ansible/ansible  
sudo apt-get update  
sudo apt-get install ansible  

```
- install python-netaddr
 ``
 sudo apt-get install python-netaddr
``
- git clone  git@github.com:kube-HPC/deploy-cluster.git

- create ssh-copy-id  for all machines 
``` 
sudo apt-get install sshpass
```
- install kubectl 
```
kubectl config set-cluster maty  --server=http://127.0.0.1:8080 
kubectl config set-context maty --cluster="maty_"
kubectl config use-context maty
kubectl cluster-info
```

## edit enviroment

enter to ``/env`` folder

### for each enviroment do the follows

#### create file 
- inventory.[cluster-name]
```yaml

[all]
# ## Configure 'ip' variable to bind kubernetes services on a
# ## different ip than the default iface
node1 ansible_ssh_host=10.32.10.6  # ip=10.3.0.1
node2 ansible_ssh_host=10.32.10.7  # ip=10.3.0.2
node3 ansible_ssh_host=10.32.10.9  # ip=10.3.0.3
node4 ansible_ssh_host=10.32.10.11  # ip=10.3.0.4
node5 ansible_ssh_host=10.32.10.12  # ip=10.3.0.5
node6 ansible_ssh_host=10.32.10.13  # ip=10.3.0.6
node7 ansible_ssh_host=10.32.10.14  # ip=10.3.0.6
node8 ansible_ssh_host=10.32.10.15  # ip=10.3.0.6
node9 ansible_ssh_host=10.32.10.16  # ip=10.3.0.6
node10 ansible_ssh_host=10.32.10.17  # ip=10.3.0.6
node11 ansible_ssh_host=10.32.10.18  # ip=10.3.0.6


[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansibler_ssh_pass=ubadmin
ansible_user=ubadmin
bootstrap_os=ubuntu
loadbalancer_apiserver_localhost=false
kube_api_pwd=ubadmin
cluster_name=azure-test

[kube-master]
node1
node2
node3

[etcd]
node1
node2
node3

[kube-node]
node4
node5
node6
node7
node8
node9
node10
node11

[k8s-cluster:children]
kube-node
kube-master

```

- [cluster-name].yaml   -that add variables   

``` yaml 
-- 
# Cluster Info

CLUSTER_ID: test 

# keepalived 

INSTALL_KEEPALIVED: True
interface_network: eth0
cluster_id: 3
virtual_cluster_ip: 10.32.10.120

# nfs server 

NFS_SERVER: 10.32.10.26
NFS_ROOT: /srv/vol_nfs
USE_PERSISTANT_VOLUMES: True

##INSTALL_NFS_HOST: False

url_username: kube
url_password: SoundFactory

# Kibana 
KIBANA_EXTERNAL_IP: 10.32.10.120

# Elastic Defualt Configuration 

LOGGING_ES_PV_SIZE: 100Gi
LOGGING_ES_REPLICAS_MASTER: 1
LOGGING_ES_REPLICAS_CLIENT: 1
LOGGING_ES_REPLICAS_DATA: 2
LOGGING_ES_MINIMUM_MASTERS: 1
LOGGING_ES_JAVA_HEAP_SIZE: 2g

# Prometheus Defualt Configuration

PROM_PV_SIZE: 100Gi

```
- test ansible 
```
ansible all -i env/inventory.[cluster-name] -m ping
```


## install 
### install k8s
cd scripts
#### run ./Pre-Config [cluster-name]
do the follows:
<details>
  <summary>copy id</summary>
  <p>copy id for all the cluster nodes</p>
  <p>install ntp nfs-common</p>
</details>



#### run ./Start-Cluster [cluster-name]

<details>
  <summary>run</summary>
    <p>run kubespary</p>
</details>

#### run ./Get-Cert [cluster-name] 1 ```//copy cert to kubectl```
#### run ./Post-Install [cluster-name]


#### Entering to cluster 
for entering to the cluster enter to ``https://[master-ip]:6443``   
insert your congured user for ``env/[cluster-name]``   
go to ``kubespray/credentials``    
password should be found in  ``kube_user`` (without ``\``)     
    
* in order to set your own password just create ``kube_user`` file under the following path 

### config kubectl 
enter to ``kubespray/artifacts``    
`` cp admin.conf  ~/.kube/config``    

### install system

#### run ./Start-System [cluster-name] 

<details>
  <summary>install the follows:</summary>
   <p>weave</p>
   <p>elf (fluentd)</p>
   <p>promethueus</p>
</details>



### reset cluster  ./Reset-Cluster [cluster-name]



###Other

nfs server configuration   
enter to ```/etc/exports```    
add the folowing line at the end of the file ```/srv/vol_nfs or other mounting path 10.32.10.0/24(rw,sync,no_subtree_check,no_root_squash)```

 

