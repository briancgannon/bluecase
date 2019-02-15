provider "aws" {
  shared_credentials_file = "/Users/bgannon/.aws/credentials"
  profile                 = "bluecase"
  region                  = "us-east-2"
}

variable "ec2_testbox_ami" {
  type = "string"
  default = "ami-0f65671a86f061fcd"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}

resource "aws_instance" "testbox" {
  ami = "${var.ec2_testbox_ami}"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name = "terraform-testbox"
    Environment = "sandbox"
  }
}

resource "aws_security_group" "testbox-sg" {
  name = "terraform-testbox-sg"
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


