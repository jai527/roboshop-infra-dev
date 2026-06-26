locals {
    common_tags = {
        project = var.project
        environment = var.environment
        terraform = true
    }
  public_subnet_id = split( ",", data.aws_ssm_parameter.public_subnet_id.value)[0]
  ami_id = data.aws_ami.vpn.id
  openvpn_sg_id = data.aws_ssm_parameter.openvpn_sg_id.value

}