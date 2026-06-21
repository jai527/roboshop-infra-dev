locals {

    frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
    public_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]

    common_tags ={
    project = var.project
    environment = var.environment
    terraform = true
    frontend_alb = data.aws_s
  }
}