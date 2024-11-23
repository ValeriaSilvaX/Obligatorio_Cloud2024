for i in "/root/.ssh/Obligatorio_Cloud2024/manifiestos/"; do
    kubectl delete -f $i
done

RUTA="/root/.ssh/Obligatorio_Cloud2024/terraform"
if cd "$RUTA"; then
    echo "Entrando a la ruta $RUTA"
if terraform apply -auto-approve -destroy; then
        echo "terraform apply --destroy completado exitosamente."
    else
        echo "Error al ejecutar terraform apply --destroy."
        exit 1
    fi

else
    echo "No se pudo acceder a la ruta $RUTA"
    exit 1
fi