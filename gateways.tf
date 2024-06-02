resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { Name = "${var.vpc_name}-igw" }
  )
}

resource "aws_egress_only_internet_gateway" "eigw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { Name = "${var.vpc_name}-eigw" }
  )
}