module "vpc" {
    source = "../../terraform-aws-vpc"
    project = var.project
    environment = var.environment
    is_peering_required = true


  
}

/* module "vpc" {
    source = "git::https://github.com/jai527/terraform-aws-vpc.git?ref=main"
    project = var.project
    environment = var.environment
    is_peering_required = true
  
} */