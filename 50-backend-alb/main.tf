resource "aws_lb" "backend_alb" {
  name               = "${var.project}-${var.environment}"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = local.private_subnet_id

  #kepping it is a false, just to delete using terraform practice

  enable_deletion_protection = false

  /* access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  } */

  tags = merge(
    {
        Name = "${var.project}-${var.environment}"
    },
    local.common_tags
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = 80 
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      status_code  = 200
      content_type = "text/plain"
      message_body = "ALB is working ✅"
    }
  } 
}


resource "aws_route53_record" "catalogue_alb" {
  zone_id = var.zone_id
  name    = "*.backend-alb-${var.environment}.${var.domain_name}"
  type    = "A"

    # load balancer details
  alias {
    name                   = aws_lb.backend_alb.dns_name   # ✅ ALB DNS
    zone_id                = aws_lb.backend_alb.zone_id    # ✅ ALB zone ID
    evaluate_target_health = true
  }
}
