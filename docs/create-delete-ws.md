## Install KCP kubectl plugin
```shell
wget https://github.com/kcp-dev/kcp/releases/download/v<RELEASE NUM>/kubectl-kcp-plugin_<RELEASE NUM>_linux_amd64.tar.gz
tar -zxvf kubectl-kcp-plugin_<RELEASE NUM>_linux_amd64.tar.gz
export KUBECONFIG=admin.config
kubectl get ws
kubectl kcp ws -h
```

## Run
install bc:
```shell
sudo apt-get install bc
```
run create:
```shell
./kcp-workspace/create.sh <ws name suffix> <num of WS to create>
```
run delete:
```shell
./kcp-workspace/delete.sh <ws name suffix> <num of WS to delete>
```
