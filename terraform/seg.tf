# Create Security Group
resource "aws_security_group" "subnet_security_group" {
  name        = "subnet-security-group"
  description = "Security group for the subnet"

  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080  # port 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000  # Port 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # You can add more ingress/egress rules as needed

  tags = {
    Name = "subnet-security-group"
  }
}