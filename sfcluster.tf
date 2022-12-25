# choose provider
terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
    features {}
}

#create resource group
resource "azurerm_resource_group" "RG" {
    name = "RG-Terraform"
    location = "UK South"
}

# #create virtual network in above resource group
# resource "azurerm_virtual_network" "vnet" {
#     name = "vnet-terraform"
#     location = "UK South"
#     resource_group_name = azurerm_resource_group.RG
#     address_space = [ "10.0.0.0/16" ]
# }

#create service fabric cluster
resource "azurerm_service_fabric_cluster" "sfcluster" {
    name = "sfcluster-terraform"
    resource_group_name = azurerm_resource_group.RG
    location = "UK South"
    reliability_level = "Bronze"
    upgrade_mode = "Manual"
    cluster_code_version = "9.0.1048.9590"
    vm_image = "windows"
    management_endpoint  = "https://example:80"
    #add_on_features = [ "DnsService" ]
    #service_fabric_zonal_upgrade_mode = "Parallel"   #Specifies the logical grouping of VMs in upgrade domains. Possible values are Hierarchical or Parallel.
    #vmss_zonal_upgrade_mode = "Hierarchical"         #Specifies the upgrade mode for the virtual machine scale set updates that happen in all availability zones at once. Possible values are Hierarchical or Parallel.
    #tags = {
      Environment = "development"
    }
    # #azure_active_directory {
    #     tenant_id = f338c154-12a0-4344-b99d-4c72b52cabdd
    #     cluster_application_id = egtha45-7c10-4b04-a008-408344143f4a
    #     client_application_id = c8235fb1-7c10-4b04-a008-408344143f4a
    # }
    
    node_type {
      name = "node"
      instance_count = 3
      is_primary = true
      client_endpoint_port = 2020
      http_endpoint_port = 80
      #placement_properties =                  #which can be used to indicate where certain services (workload) should run.
      #capacities = 
      #is_stateless = false
      #multiple_availability_zones = false
      #durability__level = "Bronze"
      #application_ports {
    #         start_port =
    #         end_port =
    #   }
      #ephemeral_ports {
    #         start_port =
    #         nd_port =
    #   }
      #reverse_proxy_endpoint_port = 
    }  

    #certificate_common_names{
        common_names {
          certificate_common_name = "terraform-cert"
          #certificate_issurer_thumbprint = c8455fb1-7c10-4b04-a008-408344143f4a
    #     }
    #       x509_store_name = "My"
     }

    # #certificate {
    #     #thumbprint =
    #     #thumbprint_secondary =
    #     #xx509_store_name =  
    # }

    # #reverse_proxy_certificate {
    #     thumbprint =
    #     #thumbprint_secondary =
    #     x509_store_name = 
    # }

    # #reverse_proxy_certificate_common_names {
    #     common_names {
    #       certificate_common_name = "terraform-cert"
    #       certificate_issurer_thumbprint = c8455fb1-7c10-4b04-a008-408344143f4a
    #     }
    #     x509_store_name = 
    # }

    # #client_certificate_thumbprint {
    #     thumbprint =                #The Thumbprint associated with the Client Certificate.
    #     is_admin = 
    # }

    # #client_certificate_common_name {
    #     common_name =
    #     #certificate_issurer_thumbprint =
    # }

    # #diagnostics_config {
    #     #storage_account_name =
    #     protected_account_key_name =
    #     blob_endpoint =
    #     queue_endpoint =
    #     table_endpoint = 
    # }

    # #fabric_settings {
    #     name =                    #The name of the Fabric Setting, such as Security or Federation.
    #     #parameters = 
    # }

#     upgrade_policy {
#     #     #force_restart = 
#     #     health_check_retry_timeout = "00:45:00"   #Specifies the duration, in "hh:mm:ss" string format, after which Service Fabric retries the health check if the previous health check fails.
#     #     health_check_stable_duration = "00:01:00"
#     #     health_check_wait_duration = "00:00:30"
#     #     upgrade_domain_timeout = "02:00:00"
#     #     upgrade_replica_set_check_timeout = "10675199.02:48:05.4775807"
#     #     upgrade_timeout = "12:00:00"

#         # health_policy {
#         #     max_unhealthy_applications_percent = 0
#         #     max_unhealthy_nodes_percent = 0
#         # }

#         # delta_health_policy {
#         #     max_delta_unhealthy_applications_percent = 0
#         #     max_delta_unhealthy_nodes_percent = 0
#         #     max_upgrade_domain_delta_unhealthy_nodes_percent = 0
#         # }
#     }
# }