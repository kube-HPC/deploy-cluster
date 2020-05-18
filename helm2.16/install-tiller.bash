sudo cp ./linux-amd64/helm /usr/local/bin
kubectl apply -f tiller167.yaml
helm init --service-account=tiller --history-max 300
