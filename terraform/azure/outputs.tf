output "resource_group_name" {
  description = "Azure resource group name"
  value       = module.resource_group.resource_group_name
}

output "resource_group_location" {
  description = "Azure resource group location"
  value       = module.resource_group.resource_group_location
}