terraform {

  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.113.0"
    }

  }
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"                 # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "brunovpterraformstate"              # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "remote-state"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "pipeline-github-actions/terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "Bruno-Aragao"
      managed-by = "terraform"
    }
  }
}

provider "azurerm" {

  features {}
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-terraform-state"    # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "brunovpterraformstate" # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "remote-state"
    key                  = "azure-vnet/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "brunoaragao-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}