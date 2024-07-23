resource "aws_route53_zone" "domain_name" {
  name = "hellohumans.in"
}

# Create Route 53 record with geolocation routing policy for cloudfront
resource "aws_route53_record" "india_geolocation_record" {
  zone_id        = aws_route53_zone.domain_name.zone_id
  name           = "hellohumans.in"
  type           = "A"
  set_identifier = "india"
  geolocation_routing_policy {
    continent = "AS" # Asia
  }

  alias {
    name                   = aws_cloudfront_distribution.cloudfront.dns_name
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = true

  }
}

# Create Route 53 record with geolocation routing policy for s3
resource "aws_route53_record" "india_geolocation_record_s3" {
  zone_id        = aws_route53_zone.domain_name.zone_id
  name           = "hellohumans.in"
  type           = "A"
  set_identifier = "Europe"

  geolocation_routing_policy {
    continent = "EU"
  }

  alias {
    name                   = "s3-website.ap-south-1.amazonaws.com"
    zone_id                = aws_s3_bucket.s3_website.hosted_zone_id
    evaluate_target_health = false
  }
}

output "route53_zone_name" {
  value = aws_route53_zone.domain_name.name
}