variable "aws_region" {
  description = "AWS Region for resource creation"
  type        = string
  default     = "eu-west-1"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Cluster `tags` to snapshots"
  type        = bool
  default     = true
}

# ----------------------------------------------------------------
# aws_rds_cluster
# ----------------------------------------------------------------

variable "aws_rds_cluster-cluster_identifier" {
  description = "Cluster identifier"
  type        = string
}

variable "aws_rds_cluster-availability_zones" {
  description = "availability_zone"
  type        = list(string)
  default     = [ "eu-west-1a" ]
}

variable "aws_rds_cluster-engine" {
  description = "Cluster identifier"
  type        = string
  default     = "aurora-postgresql"
}

variable "aws_rds_cluster-engine_mode" {
  description = "Cluster identifier"
  type        = string
  default     = "provisioned"
}

variable "aws_rds_cluster-engine_version" {
  description = "Cluster identifier"
  type        = string
  default     = "13.6"
}

variable "aws_rds_cluster-enable_http_endpoint" {
  description = "Enable HTTP endpoint (data API). Only valid when engine_mode is set to `serverless`"
  type        = bool
  default     = true
}

variable "aws_rds_cluster-kms_key_id" {
  description = "The ARN for the KMS encryption key. When specifying `kms_key_id`, `storage_encrypted` needs to be set to `true`"
  type        = string
  default     = null
}

variable "aws_rds_cluster-database_name" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
  default     = "fishdb"
}

variable "aws_rds_cluster-master_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "root"
}

variable "aws_rds_cluster-skip_final_snapshot" {
  description = "Determines whether a final snapshot is created before the cluster is deleted. If true is specified, no snapshot is created"
  type        = bool
  default     = true
}

variable "aws_rds_cluster-deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to `true`. The default is `false`"
  type        = bool
  default     = true
}

variable "aws_rds_cluster-backup_retention_period" {
  description = "The days to retain backups for. Default `7`"
  type        = number
  default     = 7
}

variable "aws_rds_cluster-preferred_backup_window" {
  description = "The daily time range during which automated backups are created if automated backups are enabled using the `backup_retention_period` parameter. Time in UTC"
  type        = string
  default     = "02:00-03:00"
}

variable "aws_rds_cluster-preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur, in (UTC)"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "aws_rds_cluster-storage_encrypted" {
  description = "Specifies whether the DB cluster is encrypted. The default is `true`"
  type        = bool
  default     = true
}

variable "aws_rds_cluster-iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  type        = bool
  default     = true
}

variable "aws_rds_cluster-enabled_cloudwatch_logs_exports" {
  description = "Set of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: `audit`, `error`, `general`, `slowquery`, `postgresql`"
  type        = list(string)
  default     = [ "postgresql" ]
}

variable "aws_rds_cluster-serverlessv2_scaling_configuration" {
    description = "Map of nested attributes with serverless v2 scaling properties. Only valid when `engine_mode` is set to `provisioned`"
    type        = map(string)
    default     = {
                    max_capacity = 1
                    min_capacity = 0.5
                  }
}

# ----------------------------------------------------------------
# aws_rds_cluster_instance
# ----------------------------------------------------------------

variable "aws_rds_cluster_instance-instance_class" {
  description = "aws_rds_cluster_instance-instance_class"
  type        = string
  default     = "db.serverless"
}

variable "aws_rds_cluster_instance-monitoring_interval" {
  description = "aws_rds_cluster_instance-monitoring_interval"
  type        = number
  default     = 0
}

variable "aws_rds_cluster_instance-auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default `true`"
  type        = bool
  default     = false
}

variable "aws_rds_cluster_instance-performance_insights_enabled" {
  description = "Specifies whether Performance Insights is enabled or not"
  type        = bool
  default     = false
}


variable "aws_rds_cluster_instance-performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type        = string
  default     = null
}

variable "aws_rds_cluster_instance-performance_insights_retention_period" {
  description = "Amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years)"
  type        = number
  default     = 7
}

variable "aws_rds_cluster_instance-ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance"
  type        = string
  default     = null
}
