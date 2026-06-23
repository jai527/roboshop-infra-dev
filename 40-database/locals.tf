locals {
  ami_id = data.aws_ami.joindevops

  common_tags ={
    project = var.project
    environment = var.environment
    terraform = true
  }

  database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0]
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
  redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
  rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
  mysql_role_name = "${title(var.project)}-${title(var.environment)}-Mysql"
  mysql_policy_name = "${title(var.project)}-${title(var.environment)}-Mysql"
}