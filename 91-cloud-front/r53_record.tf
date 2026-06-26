resource "aws_route53_record" "cdn" {
    zone_id = var.zone_id
    name = "${var.project}-${var.environment}-${var.domain_name}"
    type = A 

    # Load balancer details
    alias {
      name = abs
      zone_id = var.zone_id
      evaluate_target_health = true

    }
    allow_overwrite = true
}