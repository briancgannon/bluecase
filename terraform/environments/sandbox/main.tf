module "sandbox" {
  source             = "../../bluecase"
  environment        = "sandbox"
  basic_server_ami   = "ami-0f65671a86f061fcd"
  asg_min_count      = 2
  asg_max_count      = 3
}