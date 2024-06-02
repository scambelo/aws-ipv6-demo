resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.vpc_cidr
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, 0)
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = merge(
    { Name = "${var.vpc_name}-public" }
  )
}

resource "aws_subnet" "private" {
  vpc_id                                         = aws_vpc.vpc.id
  ipv6_cidr_block                                = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, 1)
  availability_zone                              = data.aws_availability_zones.azs.names[0]
  ipv6_native                                    = true
  enable_dns64                                   = true
  assign_ipv6_address_on_creation                = true
  enable_resource_name_dns_aaaa_record_on_launch = true

  tags = merge(
    { Name = "${var.vpc_name}-private" }
  )
}