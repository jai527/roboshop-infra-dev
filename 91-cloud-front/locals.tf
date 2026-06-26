locals {
  caching_disabled = data.aws_cloudfront_cache_policy.caching_disabled.id
  caching_optimized = data.aws_cloudfront_cache_policy.caching_optimized.id
  acm_certificate_arn = data.aws_ssm_parameter.frontend_alb_certificate_arn.value

  common_tags={
    project = var.project
    environment = var.environment
    terraform = true
  }
}