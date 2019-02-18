variable "env_name" {
  description = "Environment name"
  type        = "string"
  default     = "sandbox"  
}

variable "DBAllocateStorage" {
  description = "Storage size for RDS instances."
  type        = "string"
  default     = 250
}

variable "DBName" {
  description = "Database name."
  type        = "string"
  default     = ""
}

variable "DBSnapshotName" {
  description = "Database snapshot name."
  type        = "string"
  default     = ""
}



