resource "aws_security_group" "frontend" {
  name   = "e-shop-frontend-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# Crear grupo de seguridad para los servicios
resource "aws_security_group" "services" {
  name   = "e-shop-services-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.frontend.id]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# Security Group para AdService
resource "aws_security_group" "adservice" {
  name        = "adservice-sg"
  description = "Security group for AdService"
  vpc_id      = aws_vpc.main.id

  # Permitir tráfico entrante en el puerto 9555 para gRPC
  ingress {
    description     = "gRPC from other services"
    from_port       = 9555
    to_port         = 9555
    protocol        = "tcp"
    # Permite tráfico desde otros servicios en la misma VPC
    security_groups = [aws_security_group.frontend.id]
    # También puedes permitir tráfico desde otros security groups según sea necesario
  }

  # Permitir tráfico de healthcheck para las pruebas de vida/preparación
  ingress {
    description     = "Health check probe"
    from_port       = 9555
    to_port         = 9555
    protocol        = "tcp"
    # Permite tráfico desde el plano de control de Kubernetes
    security_groups = [aws_security_group.eks_control_plane.id]
  }

  # Permitir todo el tráfico saliente
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "adservice-sg"
    App  = "e-shop"
  }
}