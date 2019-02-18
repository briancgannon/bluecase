module "sandbox_application" {
  source                       = "../../modules/aws/application"
  env_name                     = "sandbox"
  DBAllocateStorage            = 250
  DBName                       = ""
  DBSnapshotName               = ""  
}