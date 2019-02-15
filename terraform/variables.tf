variable "ec2_testbox_ami" {
  type = "string"
  default = "ami-0f65671a86f061fcd"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}