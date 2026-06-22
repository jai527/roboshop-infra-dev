resource "aws_lb" "frontend_alb" {
  name               = "${var.project}-${var.environment}-frontend"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend_alb_sg_id]
  subnets            = local.public_subnet_ids
  
  #kepping it is a false, just to delete using terraform practice

  enable_deletion_protection = false

  /* access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  } */

  tags = merge(
    {
        Name = "${var.project}-${var.environment}-frontend"
    },
    local.common_tags
  )
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = 443 
  protocol          = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = local.frontend_alb_certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      status_code  = 200
      content_type = "text/plain"
      message_body = "ALB is working ✅"
    }
  } 
}


resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "*.frontend-alb-${var.environment}.${var.domain_name}"
  type    = "A"

    # load balancer details
  alias {
    name                   = aws_lb.frontend_alb.dns_name   # ✅ ALB DNS
    zone_id                = aws_lb.frontend_alb.zone_id    # ✅ ALB zone ID
    evaluate_target_health = true
  }
  allow_overwrite = true
}

