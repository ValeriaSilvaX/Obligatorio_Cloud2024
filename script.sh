#!/bin/bash

# Ruta donde se encuentra el proyecto Terraform
RUTA_TERRAFORM="/root/.ssh/Obligatorio_Cloud2024/terraform"


# Cambiar al directorio especificado
if cd "$RUTA_TERRAFORM"; then
    echo "Entrando a la ruta $RUTA_TERRAFORM"

    # Ejecutar terraform init y verificar si fue exitoso
    if terraform init; then
        echo "terraform init completado exitosamente."
    else
        echo "Error al ejecutar terraform init."
        exit 1
    fi

    # Ejecutar terraform plan y verificar si fue exitoso
    if terraform plan; then
        echo "terraform plan completado exitosamente."
    else
        echo "Error al ejecutar terraform plan."
        exit 1
    fi

    # Ejecutar terraform apply y verificar si fue exitoso
       error_msg=$(terraform apply -auto-approve 2>&1)
    if [[ "$error_msg" == *"AccessDenied: User: arn:aws:sts::"*": is not authorized to perform: iam:CreateOpenIDConnectProvider"* ]]; then
        echo "Advertencia: Terraform apply falló debido a permisos insuficientes para crear un IAM OIDC Provider. Este paso será ignorado."
    elif [[ "$error_msg" != "" ]]; then
        echo "Error al ejecutar terraform apply: $error_msg"
        exit 1
    else
        echo "terraform apply completado exitosamente."
    fi
else
    echo "No se pudo acceder a la ruta $RUTA_TERRAFORM"
    exit 1
fi



# Configurar el contexto de Kubernetes para el cluster EKS
echo "Configurando contexto de Kubernetes para EKS..."
if aws eks update-kubeconfig --name terraform-eks --region us-east-1; then
    echo "Configuración de kubeconfig completada."
else
    echo "Error al configurar kubeconfig para EKS."
    exit 1
fi

#busca todos los archivos en el directorio manifietosd y arma los pods
for i in "/root/.ssh/Obligatorio_Cloud2024/manifiestos/"; do
    kubectl apply -f $i
done
#Obtiene información de los servicios en Kubernetes que tienen una etiqueta frontend-external
url=$(kubectl get svc --selector= frontend-external | cut -d " " -f 10 | grep "elb")

echo "la url para la pagina es: "
#Imprime el valor del LB
echo "$url"