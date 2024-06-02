resource "aws_eip" "ip-nat" {
  depends_on = [aws_internet_gateway.igw]
  domain     = "vpc"

  tags = {
    Name = "EIP-NAT"
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.ip-nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "NatGW"
  }
}