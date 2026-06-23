data "aws_ssm_parameter" "frontend_alb_sg_id" {
   name = "/${var.project}/${var.environment}/frontend_alb_sg_id"
  
}

data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project}/${var.environment}/private_subnet_ids"
  
}

data "aws_ssm_parameter" "frontend_alb_certificate_arn" {
    name = "/${var.project}/${var.environment}/frontend_alb_certificate_arn"
  
}