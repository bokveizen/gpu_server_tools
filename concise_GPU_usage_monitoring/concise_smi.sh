# watch -n 1 'nvidia-smi --query-gpu=index,memory.used,memory.total,utilization.gpu --format=csv,noheader,nounits | awk -F, "{print \"GPU \" \$1 \": \" \$2 \" MiB / \" \$3 \" MiB, Utilization: \" \$4 \"%\"}"'
watch -c -n 1 'nvidia-smi --query-gpu=index,memory.used,memory.total,utilization.gpu --format=csv,noheader,nounits | awk -F", " '\''{
    if (($2+0) <= 1024 && ($4+0) <= 1) { color="\033[1;32m" } else { color="\033[1;31m" }
    printf("%sGPU %s: %s MiB / %s MiB, Utilization: %s%%\033[0m\n", color, $1, $2, $3, $4)
}'\'''