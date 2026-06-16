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

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

  # ✅ Step 1: Copy file
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  # ✅ Step 2: Execute file
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb"
    ]
  }
}



resource "aws_instance" "redis" {
    ami = data.aws_ami.joindevops.id
    instance_type = var.instance_type
    subnet_id = local.database_subnet_id
    vpc_security_group_ids = [local.redis_sg_id]
    iam_instance_profile = aws_iam_instance_profile.mysql.name

    tags = merge(
        {
            Name = "${var.project}-${var.environment}-redis"
        },

        local.common_tags
    )
  
}

resource "terraform_data" "bootstrap_redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }

  # ✅ Step 1: Copy file
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  # ✅ Step 2: Execute file
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis"
    ]
  }
}

resource "aws_instance" "mysql" {
    ami = data.aws_ami.joindevops.id
    instance_type = var.instance_type
    subnet_id = local.database_subnet_id
    vpc_security_group_ids = [local.mysql_sg_id]

    tags = merge(
        {
            Name = "${var.project}-${var.environment}-mysql"
        },

        local.common_tags
    )
  
}

resource "terraform_data" "bootstrap_mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip
  }

  # ✅ Step 1: Copy file
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  # ✅ Step 2: Execute file
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql"
    ]
  }
}


resource "aws_instance" "rabbitmq" {
    ami = data.aws_ami.joindevops.id
    instance_type = var.instance_type
    subnet_id = local.database_subnet_id
    vpc_security_group_ids = [local.rabbitmq_sg_id]

    tags = merge(
        {
            Name = "${var.project}-${var.environment}-rabbitmq"
        },

        local.common_tags
    )
  
}

resource "terraform_data" "bootstrap_rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip
  }

  # ✅ Step 1: Copy file
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  # ✅ Step 2: Execute file
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq"
    ]
  }
}