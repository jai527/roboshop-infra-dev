data "aws_ami" "vpn" {
    most_recent = true
    owners =  ["679593333241"]

    filter {
      name = "name"
    values = "OpenVPN Access Service community Image-8fbe3379"

    }

    filter {
      name = "root-device-type"
      values = ["ebs"]

    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
  
}

data "aws_ssm_parameter" "public_subnet_id" {
    name = "/${var.project}/${var.environment}/public_subnet_ids"
  
}

data "aws_ssm_parameter" "openvpn_sg_id" {
    name = "/${var.project}/${var.environment}/openvpn_sg_id"
}