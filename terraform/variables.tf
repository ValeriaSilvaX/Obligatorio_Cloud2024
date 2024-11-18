variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "perfil" {
    description = "Perfil del usuario para la configuración"
    default = default
}

variable "cluster_name" {
  description = "Nombre del clúster de EKS"
  default     = "eshop-eks-cluster"
}

variable "node_group_size" {
  description = "Cantidad de nodos en el grupo"
  default     = 3
}