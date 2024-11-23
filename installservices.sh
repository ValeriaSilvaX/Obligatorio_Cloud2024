#!/bin/bash

# Verificar si AWS CLI está instalado
if command -v aws &> /dev/null; then
    echo "AWS CLI ya está instalado."
else
    # Desinstalar la versión actual de AWS CLI si está instalada
    echo "Desinstalando la versión actual de AWS CLI (si está instalada)..."
    sudo yum remove -y awscli curl

    # Descargar la última versión de AWS CLI v2
    echo "Descargando AWS CLI v2..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

    # Descomprimir el archivo descargado
    echo "Descomprimiendo AWS CLI..."
    unzip awscliv2.zip

    # Instalar AWS CLI v2
    echo "Instalando AWS CLI v2..."
    sudo ./aws/install

    # Verificar que la instalación fue exitosa
    if command -v aws &> /dev/null; then
        echo "AWS CLI v2 instalado correctamente."
    else
        echo "Hubo un problema al instalar AWS CLI."
        exit 1
    fi
fi

# Verificar si kubectl está instalado
if ! command -v kubectl &> /dev/null; then
    echo "kubectl no está instalado. Procediendo con la instalación..."

    # Descargar la última versión estable de kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    # Instalar kubectl
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

    # Validar la instalación de kubectl
    if kubectl version --client &> /dev/null; then
        echo "kubectl se instaló correctamente."
    else
        echo "Hubo un error al validar la instalación de kubectl."
        exit 1
    fi
else
    echo "kubectl ya está instalado."
    kubectl version --client
fi

# Verificar si docker está instalado
if ! command -v docker &> /dev/null; then
    echo "Docker no está instalado. Procediendo con la instalación..."

    # Instalar dependencias necesarias
    sudo yum install -y yum-utils

    # Agregar repositorio de Docker
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

    # Instalar Docker CE, Docker CLI y otros componentes necesarios
    sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    # Habilitar Docker para que se inicie automáticamente con el sistema
    sudo systemctl enable docker

    # Iniciar Docker
    sudo systemctl start docker

    # Verificar que Docker se haya instalado correctamente
    if docker --version &> /dev/null; then
        echo "Docker se instaló correctamente."
    else
        echo "Hubo un error al instalar Docker."
        exit 1
    fi
else
    echo "Docker ya está instalado."
    docker --version
fi

# Verificar si terraform está instalado
if ! command -v terraform &> /dev/null; then
    echo "Terraform no está instalado. Procediendo con la instalación..."

    # Agregar repositorio de HashiCorp para RHEL
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

    # Instalar Terraform
    sudo yum -y install terraform

    # Verificar que Terraform se haya instalado correctamente
    if terraform --version &> /dev/null; then
        echo "Terraform se instaló correctamente."
    else
        echo "Hubo un error al instalar Terraform."
        exit 1
    fi
else
    echo "Terraform ya está instalado."
    terraform --version
fi