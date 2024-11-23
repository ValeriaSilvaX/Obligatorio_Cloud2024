#!/bin/bash

# Ruta donde se encuentra el proyecto Terraform

RUTA_TERRAFORM="/root/.ssh/Obligatorio_Cloud2024/terraform"

# Cambiar al directorio especificado
if cd "$RUTA_TERRAFORM"; then
    echo "Entrando a la ruta $RUTA_TERRAFORM"

    # Ejecutar terraform init
    echo "Iniciando terraform init..."
    terraform init
    
    # Ejecutar terraform plan
    echo "Ejecutando terraform plan..."
    terraform plan
    
    # Ejecutar terraform apply y capturar la salida de error
    echo "Ejecutando terraform apply..."
    erraform apply -auto-approve 
    
 
# Configurar el contexto de Kubernetes para el cluster EKS
echo "Configurando contexto de Kubernetes para EKS..."
    aws eks update-kubeconfig --name terraform-eks --region us-east-1

#busca todos los archivos en el directorio manifietosd y arma los pods
for i in "/root/.ssh/Obligatorio_Cloud2024/manifiestos/"; do
    kubectl apply -f $i
done
#Obtiene información de los servicios en Kubernetes que tienen una etiqueta frontend-external
url=$(kubectl get svc --selector= frontend-external | cut -d " " -f 10 | grep "elb")

echo "la url para la pagina es: "
#Imprime el valor del LB
echo "$url"
else
    echo "No se pudo acceder a la ruta $RUTA_TERRAFORM"
    exit 1
fi