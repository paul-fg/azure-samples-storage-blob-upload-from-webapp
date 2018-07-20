resource "azurerm_resource_group" "uploadrg" {
  name     = "uploadRG"
  location = "northcentralus"
}

resource "azurerm_storage_account" "uploadsa" {
  name                     = "uploadstorageacc"
  resource_group_name      = "${azurerm_resource_group.uploadrg.name}"
  location                 = "${azurerm_resource_group.uploadrg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "BlobStorage"
}

resource "azurerm_storage_container" "uploadimg" {
  name                  = "images"
  resource_group_name   = "${azurerm_resource_group.uploadrg.name}"
  storage_account_name  = "${azurerm_storage_account.uploadsa.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "uploadthumb" {
  name                  = "thumbnails"
  resource_group_name   = "${azurerm_resource_group.uploadrg.name}"
  storage_account_name  = "${azurerm_storage_account.uploadsa.name}"
  container_access_type = "container"
}

resource "azurerm_app_service_plan" "uploadsp" {
  name                = "uploadappserviceplan"
  location            = "${azurerm_resource_group.uploadrg.location}"
  resource_group_name = "${azurerm_resource_group.uploadrg.name}"

  sku {
    tier = "Free"
    size = "F1"
  }
}
output "location" {
  value = "${azurerm_resource_group.uploadrg.location}"
}
output "svplanid" {
  value = "${azurerm_app_service_plan.uploadsp.id}"
}
output "cimg" {
  value = "${azurerm_storage_container.uploadimg.name}"
}
output "cthumb" {
  value = "${azurerm_storage_container.uploadthumb.name}"
}
output "sa_primary_access_key" {
  value = "${azurerm_storage_account.uploadsa.primary_access_key}"
}
output "saname" {
  value = "${azurerm_storage_account.uploadsa.name}"
}
output "rgname" {
  value = "${azurerm_resource_group.uploadrg.name}"
}
output "sa_primary_connection_string" {
  value = "${azurerm_storage_account.uploadsa.primary_connection_string}"
}

