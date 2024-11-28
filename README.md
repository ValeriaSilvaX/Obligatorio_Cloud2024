<h1 aling:"center"> Facultad de ingeniería | Escuela de tecnología | Analista en Infraestructura Informática</h1>

<p align="center">
  <img src="Extras/Imagenes/ortLogo.jpg" alt="Universidad ORT Uruguay" width=100%>
</p>

<h2 align="center">Implementación de soluciones Cloud</h2>

Estimado visitante, sea bienvenidos al repositorio de GitHub del equipo Silva-Olveira.

En este respositorio se encuentra el proyecto realizado en el obligatorio de Soluciones en Implementaciones Cloud.

Nuestro repositorio es de contenido incremental, ya que a medida que se fue trabajando en el obligatorio, se fueron subiendo los cambios, trabajando con las mejores practicas.

## Descripción

Este proyecto esta diseñado en sistema operativo Linux CentOs, por lo que sugerimos correrlo en el mismo.En caso se no tenero correrlo en una maquina virtual.

Para poder ejecutar este proyecto, es fundamental tener instalados AWS CLI, Docker, Terraform y K8s. Las versiones requeridas de estas herramientas se especificarán más abajo, en caso de que desees instalarlas por tu cuenta.

## Requisitos del Sistema

- **Docker**
  - Versión: 27.3.1
  - Build: ce12230

- **Kubernetes**
  - Client Version: v1.31.3
  - Kustomize Version: v5.4.2

**Nota**: Se recomienda utilizar estas versiones específicas para garantizar la compatibilidad y el correcto funcionamiento del proyecto.

<strong>Microservicios a desplegar en Cloud</strong>

La aplicación Boutique esta compuesta por once microservicios que estan desarrollados en diferentes lenguajes.

<p align="center">
  <img src="Extras/Imagenes/IntroApp.png" alt="Universidad ORT Uruguay" width=100%>
</p>

## Datos de infraestructura

<strong>Servicios de AWS utilizados</strong>
  - EC2
      - Tipo de instancias: t3.medium
  - EKS
  - VPC
  - Auto Scaling Groups
  - NAT Gateway
  - Internet Gatewat
  - Elastic Load Balanced
  - Secuity Groups
  - Docker

<strong>Bloques CIDRs</strong>

Para generar la VPC se utilizo el bloque 10.0.0.0/16. Luego dicho bloque fue separado en las siguientes subredes. También se utilizo la región "us-east-1", con dos zonas de disponibilidad "us-east-1a" y "us-east-1b".
  - Subnet Privada 1 - 10.0.2.0/24
  - Subnet Privada 2 - 10.0.4.0/24
  - Subnet Publica 1 - 10.0.1.0/24
  - Subnet Publica 2 - 10.0.3.0/24

## Diagrama
  <img src="Extras/Imagenes/Diagrama Cloud.drawio (1).png">

# Deployment  

Este documento describe los pasos necesarios para desplegar la aplicación correctamente.  

---

## **Requisitos previos**  
Asegúrate de tener instalados los siguientes servicios:  
- **Docker**  
- **Kubernetes**  
- **Terraform**  
- **AWS CLI**  

Si alguno de estos servicios no está instalado, puedes ejecutar el script [`installservices.sh`](./installservices.sh). Este script verificará la instalación de los servicios y los instalará automáticamente si es necesario.
Para ejecutarlo, asegúrate de estar en la carpeta del proyecto (`Obligatorio_Cloud2024`) y utiliza el siguiente comando:  
./installservices.sh  
---

## **Configuración de Docker Hub**  
1. Crea una cuenta en [Docker Hub](https://hub.docker.com/).  
2. Asegúrate de tener tus credenciales de inicio de sesión listas para el siguiente paso.  

---

## **Creación y subida de la imagen Docker**  
Ejecuta el script [`autoDocker.sh`](./autoDocker.sh), el cual se encargará de:  
1. Iniciar sesión en Docker Hub.  
2. Construir la imagen Docker basada en el Dockerfile de tu proyecto.  
3. Subir la imagen al repositorio de tu cuenta en Docker Hub.  

Para ejecutarlo, asegúrate de estar en la carpeta del proyecto (`Obligatorio_Cloud2024`) y utiliza el siguiente comando:  
./autoDocker.sh

**Notas adicionales**  
Las imagenes pueden sacarse del directorio "src" dentro del directorio "`Obligatorio_Cloud2024`"


---

## **Despliegue de la infraestructura y servicios**  
Para desplegar la infraestructura en AWS y los servicios en Kubernetes, ejecuta el script [`terraform.sh`](./terraform.sh). Este script realiza las siguientes tareas:  
- Configura Terraform para gestionar la infraestructura.  
- Crea los recursos necesarios en AWS, incluido un clúster y nodos EKS.  
- Despliega los servicios en el clúster Kubernetes utilizando los manifiestos definidos en el proyecto.

Para ejecutarlo, asegúrate de estar en la carpeta del proyecto (`Obligatorio_Cloud2024`) y utiliza el siguiente comando:  
./autoDocker.sh

---

## **Notas adicionales**  
- Asegúrate de revisar los archivos de configuración antes de ejecutar los scripts para adaptarlos a tus necesidades.  
 
---

¡Con estos pasos, tendrás tu aplicación lista y funcionando correctamente! 🎉 

## Equipo de alumnos

El grupo de alumnos del oligatorio son los siguientes

</p>
<p align = "center"><strong>Valeria Silva</strong></p>
<p align = "center"><strong>VS267838@fi365.ort.edu.uy</strong></p>
<p align = "center"><strong>Número de estudiante - 267838</strong></p>

</p>
<p align = "center"><strong>Facundo Olveira</strong></p>
<p align = "center"><strong>FO275181@fi365.ort.edu.uy</strong></p>
<p align = "center"><strong>Número de estudiante - 275181</strong></p>


<p align="center">
  <strong>Docente:</strong> Mauricio Amendola
</p>

## Bibliografía

- [Aulas](https://aulas.ort.edu.uy/)
- [AWS](https://docs.aws.amazon.com/)
- [Docker](https://www.docker.com/)
- [Kubernetes](https://kubernetes.io/es/)
- [Terraform](https://www.terraform.io/)