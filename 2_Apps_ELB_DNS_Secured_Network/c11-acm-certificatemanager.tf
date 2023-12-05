# module "acm" {
#   source  = "terraform-aws-modules/acm/aws"
#   version = "~> 4.0"

#   domain_name = "gangadharrecruitcrm.shop"
#   zone_id     = "b7d259641bf30b89887c943ffc9d2138"

#   validation_method = "DNS"

#   subject_alternative_names = [
#     "*.weekly.tf",
#   ]

#   create_route53_records  = false
#   validation_record = [
#     "_689571ee9a5f9ec307c512c5d851e25a.weekly.tf",
#   ]

#   tags = {
#     Name = "weekly.tf"
#   }
# }


# to craete and verify ssl
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "2.14.0"
  

  domain_name  = "gangadharrecruitcrm.shop"
  zone_id      = data.aws_route53_zone.mydomain.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.gangadharrecruitcrm.shop"
  ]

#   wait_for_validation = true

  tags = {
    Name = "my-domain.com"
  }

}

#output acm -arm

output "this_acm_certificate_arn" {
    value = module.acm.this_acm_certificate_arn
  
}