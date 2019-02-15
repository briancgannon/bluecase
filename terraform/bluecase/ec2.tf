esource "aws_launch_configuration" "testbox-lc" {
  image_id = "${var.basic_server_ami}"
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
  availability_zones = ["${var.availability_zones}"]

  load_balancers = ["${aws_elb.testbox-elb.name}"]
  health_check_type = "ELB"

  min_size = "${var.asg_min_count}" 
  max_size = "${var.asg_max_count}"
  tag {
    key = "Name"
    value = "testbox-asg"
    propagate_at_launch = true
  }
}