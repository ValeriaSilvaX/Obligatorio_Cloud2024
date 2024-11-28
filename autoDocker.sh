#!/bin/bash

# Solicitar inicio de sesión en Docker Hub
echo "Inicia sesión en Docker Hub para continuar."
read -p "Usuario de Docker Hub: " docker_user
docker login -u "$docker_user"

# Verificar si el inicio de sesión fue exitoso
if [ $? -ne 0 ]; then
  echo "Error al iniciar sesión en Docker Hub. Por favor, verifica tus credenciales."
  exit 1
fi

echo "Inicio de sesión exitoso en Docker Hub."

# Solicitar detalles de construcción de la imagen
read -p "Ingresa el directorio donde se encuentra el Dockerfile (por defecto, el directorio actual): " DOCKERFILE_DIR
DOCKERFILE_DIR=${DOCKERFILE_DIR:-"."}

read -p "Ingresa el nombre de la imagen (por defecto: myapp): " IMAGE_NAME
IMAGE_NAME=${IMAGE_NAME:-"myapp"}

read -p "Ingresa la etiqueta de la imagen (por defecto: latest): " IMAGE_TAG
IMAGE_TAG=${IMAGE_TAG:-"v1"}

read -p "Ingresa el repositorio remoto para el push (por defecto: docker.io/$docker_user): " REMOTE_REPO
REMOTE_REPO=${REMOTE_REPO:-"docker.io/$docker_user"}

# Verificar si el Dockerfile existe en el directorio
if [[ ! -f "$DOCKERFILE_DIR/Dockerfile" ]]; then
  echo "Error: No se encontró un archivo Dockerfile en $DOCKERFILE_DIR"
  exit 1
fi

# Construir la imagen Docker
echo "Construyendo la imagen Docker: $IMAGE_NAME:$IMAGE_TAG"
docker build -t "$IMAGE_NAME:$IMAGE_TAG" "$DOCKERFILE_DIR"

# Verificar si la construcción fue exitosa
if [[ $? -ne 0 ]]; then
  echo "Error al construir la imagen Docker."
  exit 1
fi
echo "Imagen $IMAGE_NAME:$IMAGE_TAG creada con éxito."

# Etiquetar la imagen para el repositorio remoto
REMOTE_IMAGE="$REMOTE_REPO/$IMAGE_NAME:$IMAGE_TAG"
echo "Etiquetando la imagen como: $REMOTE_IMAGE"
docker tag "$IMAGE_NAME:$IMAGE_TAG" "$REMOTE_IMAGE"

# Push al repositorio remoto
echo "Subiendo la imagen a $REMOTE_REPO"
docker push "$REMOTE_IMAGE"

# Verificar si el push fue exitoso
if [[ $? -eq 0 ]]; then
  echo "Imagen $REMOTE_IMAGE subida con éxito."
else
  echo "Error al subir la imagen al repositorio remoto."
  exit 1
fi