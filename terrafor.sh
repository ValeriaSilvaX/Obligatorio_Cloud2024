#!/bin/bash

# Ruta donde se encuentra el proyecto Terraform
RUTA="/root/.ssh/Obligatorio_Cloud2024/terraform"

# Cambiar al directorio especificado
if cd "$RUTA"; then
    echo "Entrando a la ruta $RUTA"

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

    # Ejecutar terraform validate y verificar si fue exitoso
    if terraform apply; then
        echo "terraform validate completado exitosamente."
    else
        echo "Error al ejecutar terraform validate."
        exit 1
    fi

else
    echo "No se pudo acceder a la ruta $RUTA"
    exit 1
fi