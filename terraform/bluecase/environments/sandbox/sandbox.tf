module "main" {
  source = "../../modules"
}

data "aws_availability_zones" "all" {}

resource "aws_launch_configuration" "testbox-lc" {
  image_id = "${var.ec2_testbox_ami}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.testbox-sg.id}"] 
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "testbox-asg" {
  launch_configuration = "${aws_launch_configuration.testbox-lc.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  load_balancers = ["${aws_elb.testbox-elb.name}"]
  health_check_type = "ELB"

  min_size = 0
  max_size = 10
  tag {
    key = "Name"
    value = "testbox-asg"
    propagate_at_launch = true
  }
}

resource "aws_elb" "testbox-elb" {
  name = "testbox-elb"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  security_groups = ["${aws_security_group.testbox-elb-sg.id}"]

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "${var.server_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:${var.server_port}/"
  }
}

resource "aws_security_group" "testbox-elb-sg" {
  name = "testbox-elb-sg"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

output "elb_dns_name" {
  value = "${aws_elb.testbox-elb.dns_name}"
}

resource "aws_kms_key" "bluecase-s3-kms-key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}


resource "aws_s3_bucket" "bluecase-terraform-state-bucket" {
  bucket = "bluecase-terraform-state"
  region = "us-east-2"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.bluecase-s3-kms-key.arn}"  
        sse_algorithm     = "aws:kms"
      }
    }
  } 

  lifecycle {
      prevent_destroy = true
    }

  tags {
      Name = "bluecase-terraform-state-bucket"
    }
}
