### Manual nodes Labeling example 

for host in `ansible -i env/inventory.$NAME kube-node --list | grep -v host`; 
do echo "Labeling $host...";
kubectl label nodes --overwrite=true  $host worker=true; 
kubectl label nodes --overwrite=true  $host core=true; 
kubectl label nodes --overwrite=true  $host "third-party"=true;
done


### Manual labeling the masters
for host in `ansible -i ../env/inventory.$NAME kube-master --list | grep -v host`
do
echo "Labeling $host...";
kubectl label nodes --overwrite=true  $host api=true;
kubectl label nodes --overwrite=true  $host "reverse-proxy"=true;
kubectl label nodes --overwrite=true  $host worker=true;
kubectl label nodes --overwrite=true  $host core=true;
kubectl label nodes --overwrite=true  $host "third-party"=true;
done

### Manual Labeling GPU-Nodes

for host in `ansible -i ../env/inventory.$NAME gpu-node --list | grep -v host`
do
echo "Labeling $host...";
kubectl label nodes --overwrite=true  $host nvidia-tesla-k80=true;
done
