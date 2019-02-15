esource "aws_launch_configuration" "testbox-lc" {
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

  min_size = 2
  max_size = 10
  tag {
    key = "Name"
    value = "testbox-asg"
    propagate_at_launch = true
  }
}