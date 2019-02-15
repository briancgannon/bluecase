variable "environment" {
  type = "string"
  default = "sandbox"
}

variable "basic_server_ami" {
  description = "Ubuntu 18.04 AMI"
  type = "string"
  default = "ami-0f65671a86f061fcd"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}

variable "asg_min_count" {
  description = "Minimum count for ASG instances"
  default = 1
}

variable "asg_max_count" {
  description = "Maximum count for ASG instances"
  default = 3
}
