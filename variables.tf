variable "sagemaker_data_quality_job_definitions" {
  description = <<EOT
Map of sagemaker_data_quality_job_definitions, attributes below
Required:
    - role_arn
    - data_quality_app_specification (block):
        - environment (optional)
        - image_uri (required)
        - post_analytics_processor_source_uri (optional)
        - record_preprocessor_source_uri (optional)
    - data_quality_job_input (block):
        - batch_transform_input (optional, block):
            - data_captured_destination_s3_uri (required)
            - dataset_format (required, block):
                - csv (optional, block):
                    - header (optional)
                - json (optional, block):
                    - line (optional)
            - local_path (optional)
            - s3_data_distribution_type (optional)
            - s3_input_mode (optional)
        - endpoint_input (optional, block):
            - endpoint_name (required)
            - local_path (optional)
            - s3_data_distribution_type (optional)
            - s3_input_mode (optional)
    - data_quality_job_output_config (block):
        - kms_key_id (optional)
        - monitoring_outputs (required, block):
            - s3_output (required, block):
                - local_path (optional)
                - s3_upload_mode (optional)
                - s3_uri (required)
    - job_resources (block):
        - cluster_config (required, block):
            - instance_count (required)
            - instance_type (required)
            - volume_kms_key_id (optional)
            - volume_size_in_gb (required)
Optional:
    - name
    - region
    - tags
    - tags_all
    - data_quality_baseline_config (block):
        - constraints_resource (optional, block):
            - s3_uri (optional)
        - statistics_resource (optional, block):
            - s3_uri (optional)
    - network_config (block):
        - enable_inter_container_traffic_encryption (optional)
        - enable_network_isolation (optional)
        - vpc_config (optional, block):
            - security_group_ids (required)
            - subnets (required)
    - stopping_condition (block):
        - max_runtime_in_seconds (optional)
EOT

  type = map(object({
    role_arn = string
    name     = optional(string)
    region   = optional(string)
    tags     = optional(map(string))
    tags_all = optional(map(string))
    data_quality_app_specification = object({
      environment                         = optional(map(string))
      image_uri                           = string
      post_analytics_processor_source_uri = optional(string)
      record_preprocessor_source_uri      = optional(string)
    })
    data_quality_job_input = object({
      batch_transform_input = optional(object({
        data_captured_destination_s3_uri = string
        dataset_format = object({
          csv = optional(object({
            header = optional(bool)
          }))
          json = optional(object({
            line = optional(bool)
          }))
        })
        local_path                = optional(string)
        s3_data_distribution_type = optional(string)
        s3_input_mode             = optional(string)
      }))
      endpoint_input = optional(object({
        endpoint_name             = string
        local_path                = optional(string)
        s3_data_distribution_type = optional(string)
        s3_input_mode             = optional(string)
      }))
    })
    data_quality_job_output_config = object({
      kms_key_id = optional(string)
      monitoring_outputs = object({
        s3_output = object({
          local_path     = optional(string)
          s3_upload_mode = optional(string)
          s3_uri         = string
        })
      })
    })
    job_resources = object({
      cluster_config = object({
        instance_count    = number
        instance_type     = string
        volume_kms_key_id = optional(string)
        volume_size_in_gb = number
      })
    })
    data_quality_baseline_config = optional(object({
      constraints_resource = optional(object({
        s3_uri = optional(string)
      }))
      statistics_resource = optional(object({
        s3_uri = optional(string)
      }))
    }))
    network_config = optional(object({
      enable_inter_container_traffic_encryption = optional(bool)
      enable_network_isolation                  = optional(bool)
      vpc_config = optional(object({
        security_group_ids = set(string)
        subnets            = set(string)
      }))
    }))
    stopping_condition = optional(object({
      max_runtime_in_seconds = optional(number)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        length(v.data_quality_app_specification.image_uri) <= 255
      )
    ])
    error_message = "[from validImage: invalid when len(value) > 255]"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.data_quality_app_specification.post_analytics_processor_source_uri == null || ((can(regex("^(https|s3)://([^/])/?(.*)$", v.data_quality_app_specification.post_analytics_processor_source_uri))) && (length(v.data_quality_app_specification.post_analytics_processor_source_uri) >= 1 && length(v.data_quality_app_specification.post_analytics_processor_source_uri) <= 512))
      )
    ])
    error_message = "all of: must be between 1 and 512 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.data_quality_app_specification.record_preprocessor_source_uri == null || ((can(regex("^(https|s3)://([^/])/?(.*)$", v.data_quality_app_specification.record_preprocessor_source_uri))) && (length(v.data_quality_app_specification.record_preprocessor_source_uri) >= 1 && length(v.data_quality_app_specification.record_preprocessor_source_uri) <= 512))
      )
    ])
    error_message = "all of: must be between 1 and 512 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.data_quality_baseline_config == null || (v.data_quality_baseline_config.constraints_resource == null || (v.data_quality_baseline_config.constraints_resource.s3_uri == null || ((can(regex("^(https|s3)://([^/])/?(.*)$", v.data_quality_baseline_config.constraints_resource.s3_uri))) && (length(v.data_quality_baseline_config.constraints_resource.s3_uri) >= 1 && length(v.data_quality_baseline_config.constraints_resource.s3_uri) <= 512))))
      )
    ])
    error_message = "all of: must be between 1 and 512 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.data_quality_baseline_config == null || (v.data_quality_baseline_config.statistics_resource == null || (v.data_quality_baseline_config.statistics_resource.s3_uri == null || ((can(regex("^(https|s3)://([^/])/?(.*)$", v.data_quality_baseline_config.statistics_resource.s3_uri))) && (length(v.data_quality_baseline_config.statistics_resource.s3_uri) >= 1 && length(v.data_quality_baseline_config.statistics_resource.s3_uri) <= 512))))
      )
    ])
    error_message = "all of: must be between 1 and 512 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.data_quality_job_input.batch_transform_input == null || ((can(regex("^(https|s3)://([^/])/?(.*)$", v.data_quality_job_input.batch_transform_input.data_captured_destination_s3_uri))) && (length(v.data_quality_job_input.batch_transform_input.data_captured_destination_s3_uri) >= 1 && length(v.data_quality_job_input.batch_transform_input.data_captured_destination_s3_uri) <= 512))
      )
    ])
    error_message = "all of: must be between 1 and 512 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.data_quality_job_input.batch_transform_input == null || (v.data_quality_job_input.batch_transform_input.local_path == null || ((length(v.data_quality_job_input.batch_transform_input.local_path) >= 1 && length(v.data_quality_job_input.batch_transform_input.local_path) <= 1024) && (can(regex("^\\/opt\\/ml\\/processing\\/.*", v.data_quality_job_input.batch_transform_input.local_path)))))
      )
    ])
    error_message = "all of: must be between 1 and 1024 characters; Must start with `/opt/ml/processing`."
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.data_quality_job_input.endpoint_input == null || (length(v.data_quality_job_input.endpoint_input.endpoint_name) <= 63)
      )
    ])
    error_message = "[from validName: invalid when len(value) > 63]"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.data_quality_job_input.endpoint_input == null || (v.data_quality_job_input.endpoint_input.local_path == null || ((length(v.data_quality_job_input.endpoint_input.local_path) >= 1 && length(v.data_quality_job_input.endpoint_input.local_path) <= 1024) && (can(regex("^\\/opt\\/ml\\/processing\\/.*", v.data_quality_job_input.endpoint_input.local_path)))))
      )
    ])
    error_message = "all of: must be between 1 and 1024 characters; Must start with `/opt/ml/processing`."
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.data_quality_job_output_config.monitoring_outputs.s3_output.local_path == null || ((length(v.data_quality_job_output_config.monitoring_outputs.s3_output.local_path) >= 1 && length(v.data_quality_job_output_config.monitoring_outputs.s3_output.local_path) <= 1024) && (can(regex("^\\/opt\\/ml\\/processing\\/.*", v.data_quality_job_output_config.monitoring_outputs.s3_output.local_path))))
      )
    ])
    error_message = "all of: must be between 1 and 1024 characters; Must start with `/opt/ml/processing`."
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        (can(regex("^(https|s3)://([^/])/?(.*)$", v.data_quality_job_output_config.monitoring_outputs.s3_output.s3_uri))) && (length(v.data_quality_job_output_config.monitoring_outputs.s3_output.s3_uri) >= 1 && length(v.data_quality_job_output_config.monitoring_outputs.s3_output.s3_uri) <= 512)
      )
    ])
    error_message = "all of: must be between 1 and 512 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.job_resources.cluster_config.volume_size_in_gb >= 1 && v.job_resources.cluster_config.volume_size_in_gb <= 512
      )
    ])
    error_message = "must be between 1 and 512"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_data_quality_job_definitions : (
        v.stopping_condition == null || (v.stopping_condition.max_runtime_in_seconds == null || (v.stopping_condition.max_runtime_in_seconds >= 1 && v.stopping_condition.max_runtime_in_seconds <= 3600))
      )
    ])
    error_message = "must be between 1 and 3600"
  }
  # Note: 20 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

