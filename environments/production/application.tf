module "production_application" {
  source                     = "../../modules/aws/application"
  env_name                   = "production"
  asg_instance_min_count     = 1
  asg_instance_max_count     = 2
  database_engine            = "PostgreSQL"
  database_engine_version    = "10.4"
  database_allocated_storage = 250
  database_name              = ""
  database_snapshot_name     = ""  
}