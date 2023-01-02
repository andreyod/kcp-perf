## Start KCP
```shell
./bin/kcp start
```

## Run in other terminal
```shell
export KUBECONFIG=.kcp/admin.kubeconfig
kubectl proxy
```

## Run in other terminal
```shell
curl -sK -v http://localhost:8001/clusters/root/debug/pprof/heap > heap.out
sudo apt-get install graphviz gv
go tool pprof -http=:8080 heap.out
```

## Browser:
http://localhost:8080
