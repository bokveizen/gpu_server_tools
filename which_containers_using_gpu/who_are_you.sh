#!/bin/bash

# save this file as "who_are_you.sh"
# chmod +x who_are_you.sh (intialize the script)
# ./who_are_you.sh <GPU_ID>
# Note: "bash who_are_you.sh <GPU_ID>" should also work

GPU_ID=$1

# gpu_pids=$(nvidia-smi -i $GPU_ID --query-compute-apps=pid --format=csv,noheader)
gpu_info=$(nvidia-smi -i $GPU_ID --query-compute-apps=pid,used_memory --format=csv,noheader)

# if not running any processes, exit
if [ -z "$gpu_info" ]; then
    echo "No processes running on GPU $GPU_ID"
    exit 0
fi

# for pid, memory in $gpu_info; do
echo "$gpu_info" | while IFS=',' read -r pid memory; do
    containerd_shim_pid=$(pstree -sg $pid | grep -o 'containerd-shim([0-9]\+)' | grep -o '[0-9]\+')


    if [ -z "$containerd_shim_pid" ]; then
        echo "cannot find containerd-shim pid"
        exit 1
    fi

    # echo "containerd-shim PID: $containerd_shim_pid"

    # container_id=$(ps aux | grep $containerd_shim_pid | grep -oP '(?<=-id )\w+')
    if ps aux | grep -q "$containerd_shim_pid" 2>/dev/null; then
        container_id=$(ps aux | grep "$containerd_shim_pid" 2>/dev/null | grep -oP '(?<=-id )\w+')
    else
        echo "Process $containerd_shim_pid not found"
        continue
    fi    

    # if [ -z "$container_id" ]; then
    #     container_id=$(ps aux | grep $containerd_shim_pid | grep -oP '(?<=-workdir /var/lib/containerd/io.containerd.runtime.v1.linux/moby/)\w+')
    # fi
    if [ -z "$container_id" ]; then
        if ps aux | grep -q "$containerd_shim_pid" 2>/dev/null; then
            container_id=$(ps aux | grep "$containerd_shim_pid" 2>/dev/null | grep -oP '(?<=-workdir /var/lib/containerd/io.containerd.runtime.v1.linux/moby/)\w+')
        else
            echo "Process $containerd_shim_pid not found"
            continue
        fi
    fi

    if [ -z "$container_id" ]; then
        echo "Cannot find container ID"
        exit 1
    fi

    short_container_id=$(echo $container_id | cut -c 1-12)
    # echo "Container ID: $short_container_id"
        
    container_name=$(docker ps -a | grep $short_container_id | awk '{print $NF}')
    
    echo "PID: $pid, Memory: $memory, Container Name: $container_name"
done
