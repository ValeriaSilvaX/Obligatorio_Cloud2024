
#Defino rol IAM para dar permisos sobre EKS
data "aws_iam_role" "labrole-arn" {
    name = "LabRole"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.21"

  cluster_name    = "terraform-eks"
  cluster_version = "1.26"

  cluster_endpoint_public_access  = true

  vpc_id                   = aws_vpc.main.id
  subnet_ids               = [aws_subnet.public1.id, aws_subnet.public2.id]
  control_plane_subnet_ids = [aws_subnet.public1.id, aws_subnet.public2.id]
  iam_role_arn             = var.aws_iam_role
  create_iam_role          = false

  eks_managed_node_groups = {
    workers = {
      min_size     = 2
      max_size     = 3
      desired_size = 2

      instance_types           = ["t3.medium"]
      capacity_type            = "ON_DEMAND"
      iam_role_arn             = var.aws_iam_role
      iam_instance_profile_arn = var.aws_iam_role
      create_iam_role          = false
      create_role              = false
      subnet_ids               = [aws_subnet.private1.id, aws_subnet.private2.id]
    }
  }

  # Reglas adicionales para el grupo de seguridad de los nodos
  node_security_group_additional_rules = {
    ingress_rule = {
      description = "Allow all inbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"            kub
      cidr_blocks = ["0.0.0.0/0"]   
      type        = "ingress"
    },

    egress_rule = {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"            
      cidr_blocks = ["0.0.0.0/0"]   
      type        = "egress"
    }
  }
}
