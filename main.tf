resource "aws_sagemaker_data_quality_job_definition" "sagemaker_data_quality_job_definitions" {
  for_each = var.sagemaker_data_quality_job_definitions

  role_arn = each.value.role_arn
  name     = each.value.name
  region   = each.value.region
  tags     = each.value.tags
  tags_all = each.value.tags_all

  data_quality_app_specification {
    environment                         = each.value.data_quality_app_specification.environment
    image_uri                           = each.value.data_quality_app_specification.image_uri
    post_analytics_processor_source_uri = each.value.data_quality_app_specification.post_analytics_processor_source_uri
    record_preprocessor_source_uri      = each.value.data_quality_app_specification.record_preprocessor_source_uri
  }

  data_quality_job_input {
    dynamic "batch_transform_input" {
      for_each = each.value.data_quality_job_input.batch_transform_input != null ? [each.value.data_quality_job_input.batch_transform_input] : []
      content {
        data_captured_destination_s3_uri = batch_transform_input.value.data_captured_destination_s3_uri
        dataset_format {
          dynamic "csv" {
            for_each = batch_transform_input.value.dataset_format.csv != null ? [batch_transform_input.value.dataset_format.csv] : []
            content {
              header = csv.value.header
            }
          }
          dynamic "json" {
            for_each = batch_transform_input.value.dataset_format.json != null ? [batch_transform_input.value.dataset_format.json] : []
            content {
              line = json.value.line
            }
          }
        }
        local_path                = batch_transform_input.value.local_path
        s3_data_distribution_type = batch_transform_input.value.s3_data_distribution_type
        s3_input_mode             = batch_transform_input.value.s3_input_mode
      }
    }
    dynamic "endpoint_input" {
      for_each = each.value.data_quality_job_input.endpoint_input != null ? [each.value.data_quality_job_input.endpoint_input] : []
      content {
        endpoint_name             = endpoint_input.value.endpoint_name
        local_path                = endpoint_input.value.local_path
        s3_data_distribution_type = endpoint_input.value.s3_data_distribution_type
        s3_input_mode             = endpoint_input.value.s3_input_mode
      }
    }
  }

  data_quality_job_output_config {
    kms_key_id = each.value.data_quality_job_output_config.kms_key_id
    monitoring_outputs {
      s3_output {
        local_path     = each.value.data_quality_job_output_config.monitoring_outputs.s3_output.local_path
        s3_upload_mode = each.value.data_quality_job_output_config.monitoring_outputs.s3_output.s3_upload_mode
        s3_uri         = each.value.data_quality_job_output_config.monitoring_outputs.s3_output.s3_uri
      }
    }
  }

  job_resources {
    cluster_config {
      instance_count    = each.value.job_resources.cluster_config.instance_count
      instance_type     = each.value.job_resources.cluster_config.instance_type
      volume_kms_key_id = each.value.job_resources.cluster_config.volume_kms_key_id
      volume_size_in_gb = each.value.job_resources.cluster_config.volume_size_in_gb
    }
  }

  dynamic "data_quality_baseline_config" {
    for_each = each.value.data_quality_baseline_config != null ? [each.value.data_quality_baseline_config] : []
    content {
      dynamic "constraints_resource" {
        for_each = data_quality_baseline_config.value.constraints_resource != null ? [data_quality_baseline_config.value.constraints_resource] : []
        content {
          s3_uri = constraints_resource.value.s3_uri
        }
      }
      dynamic "statistics_resource" {
        for_each = data_quality_baseline_config.value.statistics_resource != null ? [data_quality_baseline_config.value.statistics_resource] : []
        content {
          s3_uri = statistics_resource.value.s3_uri
        }
      }
    }
  }

  dynamic "network_config" {
    for_each = each.value.network_config != null ? [each.value.network_config] : []
    content {
      enable_inter_container_traffic_encryption = network_config.value.enable_inter_container_traffic_encryption
      enable_network_isolation                  = network_config.value.enable_network_isolation
      dynamic "vpc_config" {
        for_each = network_config.value.vpc_config != null ? [network_config.value.vpc_config] : []
        content {
          security_group_ids = vpc_config.value.security_group_ids
          subnets            = vpc_config.value.subnets
        }
      }
    }
  }

  dynamic "stopping_condition" {
    for_each = each.value.stopping_condition != null ? [each.value.stopping_condition] : []
    content {
      max_runtime_in_seconds = stopping_condition.value.max_runtime_in_seconds
    }
  }
}

