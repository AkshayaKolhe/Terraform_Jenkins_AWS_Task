resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    domain_name              = aws_lb.network_load_balancer.dns_name
    origin_id   = "nlb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "match-viewer"
            origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]

    }
  }

  enabled             = false
  is_ipv6_enabled     = false
  comment             = "cloudfront with nlb"
  default_root_object = ""

default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "nlb-origin"

        viewer_protocol_policy = "redirect-to-https"

}
restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}