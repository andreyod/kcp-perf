## Prerequisites
- kubectl  
- kubeadm  
- Kubernetes cluster  

## Create static pod for CRDB
```shell
kubectl create -f deploy/etcd.yaml
kubectl create -f deploy/kcp.yaml
kubectl get pods (look for etcd0 and kcp-xxxxxx running)
kubectl logs kcp-xxxxxx  (check KCP logs)
```

## Build and run k8s apiserver for CRDB
```shell
kubectl.sh exec  kcp-5d9d4dbbf8-g2d9g -- cat /data/.kcp/admin.kubeconfig
```
(copy the output to file on the system. e.g. admin.kubeconfig)

## Cluster recovery

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
