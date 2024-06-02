resource "aws_lb" "nlb" {
  name               = "ipv6-demo"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.public.id]
  ip_address_type    = "dualstack"
}

resource "aws_lb_listener" "nlb-listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb-targetgroup.arn
  }
}

resource "aws_lb_target_group" "nlb-targetgroup" {
  name            = "ipv6-demo-tg"
  target_type     = "ip"
  ip_address_type = "ipv6"
  port            = "80"
  protocol        = "TCP"
  vpc_id          = aws_vpc.vpc.id
}

resource "aws_lb_target_group_attachment" "nlb-tg-attachment" {
  target_group_arn = aws_lb_target_group.nlb-targetgroup.arn
  target_id        = one(data.aws_network_interface.instance-eni.ipv6_addresses)
  port             = 80
}

data "aws_network_interface" "instance-eni" {
  id = aws_instance.ipv6_demo.primary_network_interface_id
}