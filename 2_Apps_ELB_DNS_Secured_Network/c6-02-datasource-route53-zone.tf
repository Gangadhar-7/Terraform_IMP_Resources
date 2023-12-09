#gat dns info
data "aws_route53_zone" "mydomain" {
  name = "gangadharrecruitcrm.shop"

}

#zoneid

output "mydomain_zoneid" {
  description = "The hosted zone id of the desired hosted zone"
  value       = data.aws_route53_zone.mydomain.zone_id
}