resource "aws_instance" "testbox" {
  ami = "${var.ec2_testbox_ami}"
  instance_type = "t2.micro"
}