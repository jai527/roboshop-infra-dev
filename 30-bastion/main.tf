
resource "aws_instance" "bastion" {
    ami                    = local.ami_id
    instance_type          = var.instance_type
    subnet_id              = local.public_subnet_id
    vpc_security_group_ids = [local.bastion_sg_id]  # ✅ fixed
    iam_instance_profile = aws_iam_instance_profile.bastion.name
    root_block_device {
      volume_size = 50
      volume_type = gp3
      # EBS VOLUME TAGS
      tags = merge(
    {
      Name      = "${var.project}-${var.environment}-bastion"
      Component = "bastion"
    },
    local.common_tags

  )
    }

  tags = merge(
    {
      Name      = "${var.project}-${var.environment}-bastion"
      Component = "bastion"
    },
    local.common_tags

  )
}

resource "aws_iam_role" "bastion_role" {
  name = "${var.project}-${var.environment}-bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "bastion" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "bastion" {
  name = "${var.project}-${var.environment}-bastion"
  role = aws_iam_role.bastion_role.name

  tags = merge(
    {
        Name = "${var.project}-${var.environment}-bastion"
    },
    local.common_tags
  )
}