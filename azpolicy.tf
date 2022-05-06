resource "azurerm_resource_policy_assignment" "auditvms1" { 
 name = "audit-vm-manageddisks" 
 resource_id = "/subscriptions/5cc96e7f-0fbb-4109-933a-42f31f8deee8"
 policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d" 
 description = "Shows all virtual machines not using managed disks" 
 display_name = "Audit VMs without managed disks assignment" 
}