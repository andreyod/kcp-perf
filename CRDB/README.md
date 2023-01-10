## Prerequisites
- kubectl
- kubeadm
- Kubernetes cluster
- docker

## Create static pod for CRDB
```shell
sudo cp crdb.yaml /etc/kubernetes/manifests/
kubectl get pods -n kube-system
```

## Build and run k8s apiserver for CRDB
```shell
git clone https://github.com/stevekuznetsov/kubernetes
cd kubernetes/
git checkout skuznets/generic-storage
make quick-release-images
sudo ctr -n=k8s.io images import _output/release-images/amd64/kube-apiserver.tar
sudo crictl images (look for: k8s.gcr.io/kube-apiserver-amd64:v0.17.1-96865_d0f95410716331 )
```
Modify file /etc/kubernetes/manifests/kube-apiserver.yaml with:  
1)image: k8s.gcr.io/kube-apiserver-amd64:v0.17.1-96865_d0f95410716331  
2)- --etcd-servers=postgresql://root@0.0.0.0:26267/defaultdb?sslmode=disable  
3)- --storage-backend=crdb  
Remove the following lines:  
    /- --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt  
    /- --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt  
    /- --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key


## Cluster recovery
```shell
sudo systemctl restart kubelet
sudo kubeadm init phase upload-config all
kubectl edit configmap kubeadm-config -n kube-system -o yaml
	networking:
      	  dnsDomain: cluster.local
      	  podSubnet: 192.168.0.0/16
      	  serviceSubnet: 10.96.0.0/12
sudo kubeadm init phase upload-certs
sudo kubeadm init phase mark-control-plane
sudo kubeadm init phase addon all
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.24.0/manifests/tigera-operator.yaml
kubectl get pods -A
```

## Install Prometheus/Grafana with operator
```shell
git clone https://github.com/prometheus-operator/kube-prometheus.git
cd kube-prometheus
kubectl create -f manifests/setup
kubectl create -f manifests/
kubectl get pods -n monitoring
```
Forward ports:  
```shell
kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090 --address='0.0.0.0'
kubectl --namespace monitoring port-forward svc/grafana 3000 --address='0.0.0.0'
```
Open browser:  http://9.148.245.199:9090
