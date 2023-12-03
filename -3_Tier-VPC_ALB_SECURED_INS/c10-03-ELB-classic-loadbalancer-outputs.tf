################################################################################
# Load Balancer
################################################################################

output "id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.this_lb_id
}

output "arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.this_lb_arn
}

output "arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = module.alb.this_lb_arn_suffix
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.this_lb_dns_name
}

output "zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = module.alb.this_lb_zone_id
}

################################################################################
# Listener(s)
################################################################################

output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb.http_tcp_listener_ids
  sensitive   = true
}

# output "listener_rules" {
#   description = "Map of listeners rules created and their attributes"
#   value       = module.alb.listener_rules
#   sensitive   = true
# }

################################################################################
# Target Group(s)
################################################################################

output "target_groups" {
  description = "Map of target groups created and their attributes"
  value       = module.alb.target_group_names
}

################################################################################
# Security Group
################################################################################

# output "security_group_arn" {
#   description = "Amazon Resource Name (ARN) of the security group"
#   value       = module.alb.security_group_arn
# }

# output "security_group_id" {
#   description = "ID of the security group"
#   value       = module.alb.this_security_group_id
# }

################################################################################
# Route53 Record(s)
################################################################################

# output "route53_records" {
#   description = "The Route53 records created and attached to the load balancer"
#   value       = module.alb.route53_records
# }



