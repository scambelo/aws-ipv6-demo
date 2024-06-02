data "aws_ami" "al2023" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.4.*"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

resource "aws_instance" "ipv6_demo" {
  ami                  = data.aws_ami.al2023.id
  instance_type        = "t4g.nano"
  security_groups      = [aws_security_group.test-instance-sg.id]
  subnet_id            = aws_subnet.private.id
  iam_instance_profile = aws_iam_instance_profile.test-instance-role.id
  user_data            = file("user-data.sh")

  tags = {
    Name = "ipv6-demo"
  }
}
