resource "aws_cloudfront_distribution" "roboshop" {

  enabled         = true
  is_ipv6_enabled = false

  aliases = ["${var.project}-${var.environment}.${var.domain_name}"]

  origin {
    domain_name = "frontend-${var.environment}.${var.domain_name}"
    origin_id   = "frontend"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {

    target_origin_id = "frontend-${var.environment}.${var.domain_name}"
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = local.caching_disabled

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }   
  }

  ordered_cache_behavior {
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"
    path_pattern     = "/media/*"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = local.caching_optimized
  }

  ordered_cache_behavior {
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"
    path_pattern     = "/images/*"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = local.caching_optimized
  }

  viewer_certificate {
    acm_certificate_arn = local.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"

  tags = merge(
    {
      Name = "${var.project}-${var.environment}-frontend"
    },
    local.common_tags
  )
}
