module "sandbox_application" {
  source                       = "../../modules/aws/application"
  env_name                     = "sandbox"
  nat_gateway_ha               = true
  DBAllocatedStorage           = 100
  AppDBName                    = ""
  AppDBSnapShotName            = ""
  database_password            = ""
  DBMultiAZ                    = false
  db_instance_type             = ""
  engine_version               = ""
  backup_retention_period      = 7
}