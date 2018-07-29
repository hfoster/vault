#Subnets, NAT Gateways
data "aws_availability_zones" "available" {}

resource "aws_subnet" "private1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "private-subnet-2"
  }
}

resource "aws_subnet" "private3" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"

  tags {
    Name = "private-subnet-3"
  }
}

resource "aws_subnet" "public1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = true

  tags {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = true

  tags {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "public3" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"
  map_public_ip_on_launch = true

  tags {
    Name = "public-subnet-3"
  }
}

resource "aws_eip" "nat_ip1" {
  vpc = true

  tags {
    Name = "nat-ip-1"
  }
}

resource "aws_nat_gateway" "nat1" {
  allocation_id = "${aws_eip.nat_ip1.id}"
  subnet_id     = "${aws_subnet.public1.id}"

  tags {
    Name = "nat-gateway-1"
  }
}

resource "aws_eip" "nat_ip2" {
  vpc = true

  tags {
    Name = "nat-ip-2"
  }
}

resource "aws_nat_gateway" "nat2" {
  allocation_id = "${aws_eip.nat_ip2.id}"
  subnet_id     = "${aws_subnet.public2.id}"

  tags {
    Name = "nat-gateway-2"
  }
}

resource "aws_eip" "nat_ip3" {
  vpc = true

  tags {
    Name = "nat-ip-3"
  }
}

resource "aws_nat_gateway" "nat3" {
  allocation_id = "${aws_eip.nat_ip3.id}"
  subnet_id     = "${aws_subnet.public3.id}"

  tags {
    Name = "nat-gateway-3"
  }
}
