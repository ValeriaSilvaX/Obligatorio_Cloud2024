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

