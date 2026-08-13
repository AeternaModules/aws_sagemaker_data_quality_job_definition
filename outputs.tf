output "sagemaker_data_quality_job_definitions_id" {
  description = "Map of id values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.id if v.id != null && length(v.id) > 0 }
}
output "sagemaker_data_quality_job_definitions_arn" {
  description = "Map of arn values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "sagemaker_data_quality_job_definitions_data_quality_app_specification" {
  description = "Map of data_quality_app_specification values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.data_quality_app_specification if v.data_quality_app_specification != null && length(v.data_quality_app_specification) > 0 }
}
output "sagemaker_data_quality_job_definitions_data_quality_baseline_config" {
  description = "Map of data_quality_baseline_config values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.data_quality_baseline_config if v.data_quality_baseline_config != null && length(v.data_quality_baseline_config) > 0 }
}
output "sagemaker_data_quality_job_definitions_data_quality_job_input" {
  description = "Map of data_quality_job_input values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.data_quality_job_input if v.data_quality_job_input != null && length(v.data_quality_job_input) > 0 }
}
output "sagemaker_data_quality_job_definitions_data_quality_job_output_config" {
  description = "Map of data_quality_job_output_config values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.data_quality_job_output_config if v.data_quality_job_output_config != null && length(v.data_quality_job_output_config) > 0 }
}
output "sagemaker_data_quality_job_definitions_job_resources" {
  description = "Map of job_resources values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.job_resources if v.job_resources != null && length(v.job_resources) > 0 }
}
output "sagemaker_data_quality_job_definitions_name" {
  description = "Map of name values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.name if v.name != null && length(v.name) > 0 }
}
output "sagemaker_data_quality_job_definitions_network_config" {
  description = "Map of network_config values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.network_config if v.network_config != null && length(v.network_config) > 0 }
}
output "sagemaker_data_quality_job_definitions_region" {
  description = "Map of region values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.region if v.region != null && length(v.region) > 0 }
}
output "sagemaker_data_quality_job_definitions_role_arn" {
  description = "Map of role_arn values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.role_arn if v.role_arn != null && length(v.role_arn) > 0 }
}
output "sagemaker_data_quality_job_definitions_stopping_condition" {
  description = "Map of stopping_condition values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.stopping_condition if v.stopping_condition != null && length(v.stopping_condition) > 0 }
}
output "sagemaker_data_quality_job_definitions_tags" {
  description = "Map of tags values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "sagemaker_data_quality_job_definitions_tags_all" {
  description = "Map of tags_all values across all sagemaker_data_quality_job_definitions, keyed the same as var.sagemaker_data_quality_job_definitions"
  value       = { for k, v in aws_sagemaker_data_quality_job_definition.sagemaker_data_quality_job_definitions : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

