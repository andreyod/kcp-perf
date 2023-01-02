#!/bin/bash

#export KUBECONFIG=/home/vagrant/admin.config
#kubectl get ws

if test "$#" -ne 2; then
    echo ---
    echo "Illegal number of parameters."
    echo "Name suffix and number of workspaces to delete is required."
    echo "Example:     ./delete.sh test- 100"
    echo ---
    exit 0
fi

counter=0
until [ $counter == $2 ]
do
    start=`date +%s.%N`
    kubectl delete ws $1$counter
    end=`date +%s.%N`
    runtime=$( echo "$end - $start" | bc -l )
    echo "delete workspace command latency:  $runtime seconds"
    ((counter++))
done
