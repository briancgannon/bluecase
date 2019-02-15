resource "aws_launch_configuration" "basic-server-lc" {
  image_id = "${var.basic_server_ami}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.basic-server-sg.id}"] 
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "basic-server-asg" {
  launch_configuration = "${aws_launch_configuration.basic-server-lc.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  load_balancers = ["${aws_elb.basic-server-elb.name}"]
  health_check_type = "ELB"

  min_size = "${var.asg_min_count}" 
  max_size = "${var.asg_max_count}"
  tag {
    key = "Name"
    value = "basic-server-asg"
    propagate_at_launch = true
  }
}