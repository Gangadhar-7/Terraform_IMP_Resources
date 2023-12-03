module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  version            = "5.16.0"
  name               = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]

  security_groups = [module.loadbalancer_sg.security_group_id]


  #listeners\
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0 # App1 TG associated to this listener
    }
  ]
  target_groups = [
    # App1 Target Group - TG Index = 0
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # App1 Target Group - Targets
      targets = {
        my_app1_vm1 = {
          target_id = module.ec2_private.id[0]
          port      = 80
        },
        my_app1_vm2 = {
          target_id = module.ec2_private.id[1]
          port      = 80
        }
      }
      tags = local.common_tags # Target Group Tags
    }
  ]
  tags = local.common_tags # ALB Tags
}



#classic load balancer
#  module "elb" {
#   source  = "terraform-aws-modules/elb/aws"
#   version = "4.0.1"

#   name = "${local.name}-myelb"

#   subnets         = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
#   security_groups = [module.loadbalancer_sg.security_group_id]
#   #   internal        = false

#   listener = [
#     {
#       instance_port     = 80
#       instance_protocol = "HTTP"
#       lb_port           = 80
#       lb_protocol       = "HTTP"
#     },
#     {
#       instance_port     = 80
#       instance_protocol = "HTTP"
#       lb_port           = 81
#       lb_protocol       = "HTTP"
#       #   ssl_certificate_id = "arn:aws:acm:eu-west-1:235367859451:certificate/6c270328-2cd5-4b2d-8dfd-ae8d0004ad31"
#     },
#   ]

#   health_check = {
#     target              = "HTTP:80/"
#     interval            = 30
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 5
#   }
#   #   access_logs = {
#   #     bucket = "my-access-logs-bucket"
#   #   }

#   // ELB attachments
#   number_of_instances = var.private_instance_count
#   instances           = [module.ec2_private.id[0], module.ec2_private.id[1]]

#   tags = local.common_tags
# }