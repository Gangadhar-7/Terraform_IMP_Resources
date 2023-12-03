# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances
module "loadbalancer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "loaadbalancer-sg"
  description = "Security Group with HTTP open for entire internet (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags

  ingress_with_cidr_blocks = [
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "allow port 81- from internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

}

