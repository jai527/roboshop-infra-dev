module "sg" {
    source = "../../terraform-aws-sg-modules"
    project = var.project
    environment = var.environment
    sg_name = "mongodb"
    vpc_id = local.vpc_id
  
}