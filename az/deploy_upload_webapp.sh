#az webapp deployment source config --name uploadwebapp --resource-group uploadRG --manual-integration --repo-url https://github.com/Azure-Samples/storage-blob-upload-from-webapp --branch master
az webapp deployment source config --name uploadwebapp --resource-group uploadRG --manual-integration --repo-url https://github.com/paul-fg/azure-samples-storage-blob-upload-from-webapp --branch master
