data "aws_ami" "joindevops" {
  most_recent = true

  owners = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }
}

data "aws_ssm_parameter" "database_subnet_ids" {
    name = "/${var.project}/${var.environment}/database_subnet_ids"
  
}

data "aws_ssm_parameter" "mongodb_sg_ids" {
    name = "/${var.project}/${var.environment}/mongodb_sg_ids"
  
}