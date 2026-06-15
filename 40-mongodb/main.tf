resource "aws_instance" "mongodb" {
    ami = data.aws_ami.joindevops.id
    instance_type = var.instance_type
    subnet_id = local.database_subnet_id
    vpc_security_group_ids = [local.mongodb_sg_id]

    tags = merge(
        {
            Name = "${var.project}-${var.environment}-mongodb"
        },

        local.common_tags
    )
  
}

resource "terraform_data" "bootstrap" {
  triggers_replace = [
    aws_instance.mongodb.id 
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mongodb.private_ip
  }

  provisioner "file" { 
    source = "bootstrap.sh" 
    destination = "/tmp/bootstrap.sh"
    
  }

    provisioner "remote-exec" {
    inline = [ 
        "chmod +x bootstrap.sh",
        "sudo sh bootstrap.sh"
     ]
  }
}