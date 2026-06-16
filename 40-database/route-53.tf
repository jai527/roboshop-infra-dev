resource "aws_route53_record" "mongodb_r53" {
  zone_id = var.zone_id
  name    = "mongodb-${var.environment}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "redis_r53" {
  zone_id = var.zone_id
  name    = "redis-${var.environment}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.redis.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "mysql_r53" {
  zone_id = var.zone_id
  name    = "mysql-${var.environment}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mysql.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "rabbitmq_r53" {
  zone_id = var.zone_id
  name    = "rabbitmq-${var.environment}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.rabbitmq.private_ip]
  allow_overwrite = true
}