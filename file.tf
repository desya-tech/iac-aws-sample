provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "insecure_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Example AMI
  instance_type = "t2.micro"
  
  # Vulnerability: Security Group allowing all traffic
  vpc_security_group_ids = [aws_security_group.insecure_sg.id]

  tags = {
    Name = "InsecureInstance"
  }
}

resource "aws_security_group" "insecure_sg" {
  name        = "insecure_sg"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Vulnerability: Wide open security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "insecure_sg"
  }
}

resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "insecure-bucket-example"
  acl    = "public-read" # Vulnerability: Publicly readable bucket

  tags = {
    Name = "InsecureBucket"
  }
}
