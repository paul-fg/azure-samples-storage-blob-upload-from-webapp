module "upload-base" {
  source = "../upload-base"
}
resource "azurerm_app_service" "uploadsv" {
  name                = "uploadwebapp"
  location            = "${module.upload-base.location}"
  resource_group_name = "${module.upload-base.rgname}"
  app_service_plan_id = "${module.upload-base.svplanid}"
  app_settings {
    "AzureStorageConfig__AccountName"        = "${module.upload-base.saname}"
    "AzureStorageConfig__ImageContainer"     = "${module.upload-base.cimg}"
    "AzureStorageConfig__ThumbnailContainer" = "${module.upload-base.cthumb}"
    "AzureStorageConfig__AccountKey"         = "${module.upload-base.sa_primary_access_key}"
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

