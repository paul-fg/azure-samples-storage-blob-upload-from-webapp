module "upload-base" {
  source = "../upload-base"
}
resource "azurerm_storage_account" "uploadgeneralsa" {
  name                     = "uploadgeneralstorageacc"
  resource_group_name      = "${module.upload-base.rgname}"
  location                 = "${module.upload-base.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "Storage"
}

resource "azurerm_function_app" "uploadfn" {
  name                      = "uploadfunctionapp"
  location                  = "${module.upload-base.location}"
  resource_group_name       = "${module.upload-base.rgname}"
  app_service_plan_id       = "${module.upload-base.svplanid}"
  storage_connection_string = "${azurerm_storage_account.uploadgeneralsa.primary_connection_string}"
  app_settings {
    "myblobstorage_STORAGE"="${module.upload-base.sa_primary_connection_string}"
    "myContainerName"="thumbnails"
  }
}

/*
resource "azurerm_eventhub_namespace" "uploadevns" {
  name                = "acceptanceTestEventHubNamespace"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  sku                 = "Standard"
  capacity            = 1

  tags {
    environment = "Production"
  }
}

resource "azurerm_eventhub" "test" {
  name                = "acceptanceTestEventHub"
  namespace_name      = "${azurerm_eventhub_namespace.test.name}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  partition_count     = 2
  message_retention   = 1
}
*/

