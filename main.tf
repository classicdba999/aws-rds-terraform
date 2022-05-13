provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier                  = "${var.aws_rds_cluster-cluster_identifier}"
  availability_zones                  = "${var.aws_rds_cluster-availability_zones}"
  engine                              = "${var.aws_rds_cluster-engine}"
  engine_mode                         = "${var.aws_rds_cluster-engine_mode}"
  engine_version                      = "${var.aws_rds_cluster-engine_version}"
  enable_http_endpoint                = "${var.aws_rds_cluster-enable_http_endpoint}"
  kms_key_id                          = "${var.aws_rds_cluster-kms_key_id}"
  database_name                       = "${var.aws_rds_cluster-database_name}"
  master_username                     = "${var.aws_rds_cluster-master_username}"
  master_password                     = "Oracle$123"
  skip_final_snapshot                 = "${var.aws_rds_cluster-skip_final_snapshot}"
  deletion_protection                 = "${var.aws_rds_cluster-deletion_protection}"
  backup_retention_period             = "${var.aws_rds_cluster-backup_retention_period}"
  preferred_backup_window             = "${var.aws_rds_cluster-preferred_backup_window}"
  preferred_maintenance_window        = "${var.aws_rds_cluster-preferred_maintenance_window}"
  #db_subnet_group_name                 = local.db_subnet_group_name
  #vpc_security_group_ids               = compact(concat(aws_security_group.security_group.*.id, "${var.vpc_security_group_ids}"))
  storage_encrypted                   = "${var.aws_rds_cluster-storage_encrypted}"
  iam_database_authentication_enabled = "${var.aws_rds_cluster-iam_database_authentication_enabled}"
  copy_tags_to_snapshot               = "${var.copy_tags_to_snapshot}"
  enabled_cloudwatch_logs_exports     = "${var.aws_rds_cluster-enabled_cloudwatch_logs_exports}"

  serverlessv2_scaling_configuration {
    min_capacity = "${var.aws_rds_cluster-serverlessv2_scaling_configuration["min_capacity"]}"
    max_capacity = "${var.aws_rds_cluster-serverlessv2_scaling_configuration["max_capacity"]}"
  }

  tags = "${var.tags}"
}

resource "aws_rds_cluster_instance" "instance" {
  identifier                            = "${var.aws_rds_cluster-cluster_identifier}-instance"
  cluster_identifier                    = "${var.aws_rds_cluster-cluster_identifier}"
  engine                                = "${var.aws_rds_cluster-engine}"
  engine_version                        = "${var.aws_rds_cluster-engine_version}"
  instance_class                        = "${var.aws_rds_cluster_instance-instance_class}"
  #db_subnet_group_name                 = local.db_subnet_group_name
  #monitoring_role_arn                  = local.rds_enhanced_monitoring_arn
  #monitoring_interval                  = "${var.aws_rds_cluster_instance-monitoring_interval}"
  availability_zone                     = null
  preferred_maintenance_window          = "${var.aws_rds_cluster-preferred_maintenance_window}"
  auto_minor_version_upgrade            = "${var.aws_rds_cluster_instance-auto_minor_version_upgrade}"
  performance_insights_enabled          = "${var.aws_rds_cluster_instance-performance_insights_enabled}"
  performance_insights_kms_key_id       = "${var.aws_rds_cluster_instance-performance_insights_enabled}" ? "${var.aws_rds_cluster_instance-performance_insights_kms_key_id}" : null
  performance_insights_retention_period = "${var.aws_rds_cluster_instance-performance_insights_enabled}" ? "${var.aws_rds_cluster_instance-performance_insights_retention_period}" : null
  copy_tags_to_snapshot                 = "${var.copy_tags_to_snapshot}"
  ca_cert_identifier                    = "${var.aws_rds_cluster_instance-ca_cert_identifier}"

   depends_on = [
    aws_rds_cluster.cluster
  ]

  tags = "${var.tags}"
}

resource "aws_rds_cluster_endpoint" "cluster_endpoint" {

  cluster_identifier          = "${var.aws_rds_cluster-cluster_identifier}"
  cluster_endpoint_identifier = "static"
  custom_endpoint_type        = "ANY"

  static_members   = [ aws_rds_cluster_instance.instance.id ]

  depends_on = [
    aws_rds_cluster_instance.instance
  ]

  tags = "${var.tags}"
}
