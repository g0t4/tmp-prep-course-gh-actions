terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "tls" {


}


resource "tls_private_key" "foo" {
  # https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
  algorithm = "ED25519"
  # terraform taint tls_private_key.foo  # invalidate generated key in local terraform state
}

# terraform output foo-id
output "foo-id" {
  value = tls_private_key.foo.id
}
output "foo-public" {
  value = tls_private_key.foo.public_key_pem
}
output "foo-private" {
  value     = tls_private_key.foo.private_key_pem
  sensitive = true
}

// see private notes for setup before can use terraform