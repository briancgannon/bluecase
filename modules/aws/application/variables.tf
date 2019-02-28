variable "env_name" {
  description = "Environment name"
  type        = "string"
  default     = "sandbox"  
}

variable asg_instance_min_count {
  description = "Minimum number of EC2 instances in the AutoScale Group."
  type        = "string"
  default     = 0
}

variable asg_instance_max_count {
  description = "Maximum number of EC2 instances in the AutoScale Group."
  type        = "string"
  default     = 0
}

variable "database_engine" {
  description = "Database engine family."
  type        = "string"
  default     = "Postgresql"
}

variable "database_engine_version" {
  description = "Database engine version"
  type        = "string"
  default     = "10.3"
}

variable "database_allocated_storage" {
  description = "Storage size for RDS instances."
  type        = "string"
  default     = 250
}

variable "database_name" {
  description = "Database name."
  type        = "string"
  default     = ""
}

variable "database_snapshot_name" {
  description = "Database snapshot name."
  type        = "string"
  default     = ""
}
