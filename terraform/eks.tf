module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    eks_nodes = {
      desired_capacity = var.node_group_size
      max_size         = var.node_group_size + 1
      min_size         = var.node_group_size
      instance_type    = "t3.medium"
      key_name         = var.key_pair
    }
  }

  tags = {
    "Owner"       = "eshop-team"
    "Environment" = "production"
  }
}