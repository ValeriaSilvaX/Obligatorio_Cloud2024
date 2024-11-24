# Crear VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "e-shop-vpc"
  }
}

# Crear subredes públicas y privadas
resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.azs[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "e-shop-public-subnet1"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.azs[0]

  tags = {
    Name = "e-shop-private-subnet1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.azs[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "e-shop-public-subnet2"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.azs[1]

  tags = {
    Name = "e-shop-private-subnet2"
  }
}

# Crear Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "e-shop-igw"
  }
}

# Crear Elastic IP para el NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "e-shop-nat-eip"
  }
}

# Crear NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public1.id  # Utiliza la subred pública 1 para el NAT Gateway

  depends_on = [ aws_internet_gateway.gw ]
  tags = {
    Name = "e-shop-nat-gateway"
  }
}

# Crear tabla de rutas pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "e-shop-public-rt"
  }
}

# Crear tabla de rutas privada con NAT Gateway
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id  # Redirige el tráfico de las subredes privadas al NAT Gateway
  }

  tags = {
    Name = "e-shop-private-rt"
  }
}

# Asociar subred pública 1 a la tabla de rutas pública
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

# Asociar subred pública 2 a la tabla de rutas pública
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

# Asociar subred privada 1 a la tabla de rutas privada
resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

# Asociar subred privada 2 a la tabla de rutas privada
resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}