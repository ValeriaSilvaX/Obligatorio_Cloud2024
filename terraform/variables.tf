variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "perfil" {
    description = "Perfil del usuario para la configuración"
    default = "default"
}

variable "aws_iam_role" {
  default = "arn:aws:iam::624354623866:role/LabRole"
}
variable "azs" {
  type        = list(string)
  description = "Lista de zonas de disponibilidad"
  default     = ["us-east-1a", "us-east-1b"]
}





variable "currency_container_image" {
  default = ""
}


variable "email_container_image" {
  default = ""
}


variable "frontend_container_image" {
  default = "valeriasilvax/frontend:v1"
}


variable "loadgenerator_container_image" {
  default = "valeriasilvax/loadgenerator:v1"
}


variable "paymentservice_container_image" {
  default = "valeriasilvax/paymentservice:v1"
}



variable "productcatalogservice_container_image" {
  default = "valeriasilvax/productcatalogservice:v1"
}


variable "recommendationservice_container_image" {
  default = "valeriasilvax/recommendationservice:v1"
}


variable "shippingservice_container_image" {
  default = "valeriasilvax/shippingservice:v1"
}

