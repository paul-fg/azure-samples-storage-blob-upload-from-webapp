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
resource "azurerm_app_service" "uploadsv" {
  name                = "uploadwebapp"
  location            = "${azurerm_resource_group.uploadrg.location}"
  resource_group_name = "${azurerm_resource_group.uploadrg.name}"
  app_service_plan_id = "${azurerm_app_service_plan.uploadsp.id}"
  app_settings {
    "AzureStorageConfig__AccountName"        = "${azurerm_storage_account.uploadsa.name}"
    "AzureStorageConfig__ImageContainer"     = "${azurerm_storage_container.uploadimg.name}"
    "AzureStorageConfig__ThumbnailContainer" = "${azurerm_storage_container.uploadthumb.name}"
    "AzureStorageConfig__AccountKey"         = "${azurerm_storage_account.uploadsa.primary_access_key}"
  }
}
#  site_config {
#    dotnet_framework_version = "v4.0"
#    scm_type                 = "LocalGit"
#  }
#
# source_control {
#   repo_url = "https://github.com/Azure-Samples/storage-blob-upload-from-webapp"
#   branch   = "master"
# }

resource "azurerm_storage_account" "uploadgeneralsa" {
  name                     = "uploadgeneralstorageacc"
  resource_group_name      = "${azurerm_resource_group.uploadrg.name}"
  location                 = "${azurerm_resource_group.uploadrg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "Storage"
}

resource "azurerm_function_app" "uploadfn" {
  name                      = "uploadfunctionapp"
  location                  = "${azurerm_resource_group.uploadrg.location}"
  resource_group_name       = "${azurerm_resource_group.uploadrg.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.uploadsp.id}"
  storage_connection_string = "${azurerm_storage_account.uploadgeneralsa.primary_connection_string}"
  app_settings {
    "myblobstorage_STORAGE"="${azurerm_storage_account.uploadsa.primary_connection_string}"
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
