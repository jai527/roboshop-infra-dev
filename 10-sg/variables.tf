variable "project" {
    type = string
    default = "roboshop"
  
}

variable "environment" {
    type = string
    default = "dev"
  
}

variable "sg_names" {
    type = list(string)
    default = [
        # databases
        "mongodb", "redis", "rabbitmq", "mysql",

        #backend
        "catalogue", "user", "cart", "shipping", "payment","bastion",

        #backend_alb
        "backend_alb",

        #frontend
        "frontend",
        
        #fronendALB
        "frontend_ALB"
    ]
  
}