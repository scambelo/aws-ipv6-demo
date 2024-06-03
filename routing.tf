resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Public"
  }
}

resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.pub.id
}

resource "aws_route_table" "pri" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Private"
  }
}

resource "aws_route_table_association" "pri" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.pri.id
}

resource "aws_route" "pub_ipv4_dfl" {
  route_table_id         = aws_route_table.pub.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "pub_ipv6_dfl" {
  route_table_id              = aws_route_table.pub.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.igw.id
}

resource "aws_route" "pri_ipv6_dfl" {
  route_table_id              = aws_route_table.pri.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.eigw.id
}

resource "aws_route" "pri_ipv4_dfl" {
  route_table_id              = aws_route_table.pri.id
  destination_ipv6_cidr_block = "64:ff9b::/96"
  nat_gateway_id              = aws_nat_gateway.nat-gw.id
}