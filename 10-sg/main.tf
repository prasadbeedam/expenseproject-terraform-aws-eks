module "db" {
  source = "git::https://github.com/daws-78s/terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for DB MySQL Instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "db"
}

module "ingress" {
  source = "git::https://github.com/daws-78s/terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for ingress Instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "ingress"
}

module "cluster" {
  source = "git::https://github.com/daws-78s/terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for cluster Instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "eks-control-plane"
}

module "node" {
  source = "git::https://github.com/daws-78s/terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for node Instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "eks-node"
}

module "bastion" {
  source = "git::https://github.com/daws-78s/terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for bastion Instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "bastion"
}

module "vpn" {
  source = "git::https://github.com/daws-78s/terraform-aws-securitygroup.git?ref=main"
  project_name = var.project_name
  environment = var.environment
  sg_description = "SG for vpn Instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = var.common_tags
  sg_name = "vpn"
  ingress_rules = var.vpn_sg_rules
}

# # bastion accepting from public
# resource "aws_security_group_rule" "bastion_public" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#   security_group_id = module.bastion.sg_id
# }

# # EKS cluster can be accessed from bastion host
# resource "aws_security_group_rule" "cluster_bastion" {
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   source_security_group_id = module.bastion.sg_id
#   security_group_id = module.cluster.sg_id
# }

# # EKS control plane accepting all traffic from nodes
# resource "aws_security_group_rule" "cluster_node" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "-1" # All traffic
#   source_security_group_id = module.node.sg_id
#   security_group_id = module.cluster.sg_id
# }