data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_ssm_parameter" "acm_certificate_arncertificate_arn" {
    name = "/${var.project}/${var.environment}/frontend_alb_certificate_arn"
  
}