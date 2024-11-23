for i in "/root/.ssh/Obligatorio_Cloud2024/manifiestos/"; do
    kubectl delete -f $i
done