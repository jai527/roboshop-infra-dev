resource "aws_route53_record" "mongodb_r53" {
  zone_id = var.zone_id
  name    = "${var.name}-${var.environment}-${var.project}-${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}