/* resource "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/${var.project}/${var.environment}/mongodb_sg_id"
  type  = "String"
  value = module.sg.sg_id
  
  } */

resource "aws_ssm_parameter" "sg_ids" {
    count = length(var.sg_names)
    name = "/${var.project}/${var.environment}/${var.sg_names[count.index]}_sg_ids"
    type = "String"
    value = module.sg[count.index].sg_id
  
}



# separtly i created this ssm_parameter_store for mysql password store 

resource "aws_ssm_parameter" "mysql_root_password" {
  name  = "/Roboshop/Dev/Mysql_root_password"
  type  = "SecureString"          # ✅ encrypted
  value = "RoboShop@1"            # ⚠️ your password

  tags = {
    Project     = "roboshop"
    Environment = "dev"
    Component   = "mysql"
  }
}
