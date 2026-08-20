# ☁️ Modular Azure Landing Zone Terraform Infrastructure as Code (IaC)

[![CI](https://github.com/vaibhavmahna/terraform-azure-landing-zone-blueprint/actions/workflows/ci.yml/badge.svg)](https://github.com/vaibhavmahna/terraform-azure-landing-zone-blueprint/actions/workflows/ci.yml)
[![Terraform](https://img.shields.io/badge/Terraform_v1.5+-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io)
[![Azure](https://img.shields.io/badge/Microsoft_Azure-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com)
[![Security](https://img.shields.io/badge/Security-Private_Endpoints-004085?style=for-the-badge&logo=shield&logoColor=white)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

A production-grade, environment-agnostic **Modular Infrastructure as Code (IaC)** blueprint for provisioning secure **Microsoft Azure Landing Zones** using **Terraform v1.5+**.

---

## 🎯 Architecture Diagram

```mermaid
flowchart TD
    subgraph Azure_Subscription [Azure Subscription / Landing Zone]
        subgraph Resource_Group [Resource Group: rg-landingzone-prod]
            subgraph VNet [Virtual Network: vnet-landingzone]
                Subnet_Web[Subnet: snet-web /16]
                Subnet_App[Subnet: snet-app /16]
                Subnet_Data[Subnet: snet-data /16]
            end

            subgraph Security_Layer [Security & Access Controls]
                NSG_Web[NSG: nsg-web-rules] --> Subnet_Web
                NSG_App[NSG: nsg-app-rules] --> Subnet_App
                NSG_Data[NSG: nsg-data-rules] --> Subnet_Data
            end

            subgraph Storage_Tier [Secure Enterprise Storage]
                BlobStorage[(Azure Storage Account)]
                PrivateEndpoint[Private Endpoint & Private DNS] --> BlobStorage
                LifecyclePolicy[Storage Lifecycle Policy: Hot -> Cool -> Archive] --> BlobStorage
            end

            Subnet_Data -->|Private Traffic| PrivateEndpoint
        end
    end
```

---

## ✨ Features & Architecture Highlights

- 🧩 **Modular & Reusable Architecture**: Separated into decoupled submodules (`modules/network`, `modules/security`, `modules/storage`).
- 🔐 **Zero-Trust Network Isolation**: Isolated Virtual Networks (VNets), dedicated subnets, Network Security Groups (NSGs) with default-deny inbound traffic rules.
- 💾 **Enterprise Storage Tiering**: Azure Blob Storage account configured with automated lifecycle management rules (transitions to Cool after 30 days, Archive after 90 days).
- 🛡️ **Private Endpoints**: Enforces Private Endpoint connection and Private DNS integration for Blob Storage, preventing public exposure over the internet.
- 🔒 **Remote State Management**: Parameterized backend configuration for Azure Blob Storage remote state locking.

---

## 📁 Repository Structure

```
terraform-azure-landing-zone-blueprint/
├── README.md                           # Documentation & Architecture Overview
├── main.tf                             # Root Terraform Module Configuration
├── variables.tf                        # Root Variable Declarations
├── outputs.tf                          # Root Module Outputs
├── terraform.tfvars.example            # Sample Variables File
├── modules/
│   ├── network/                        # VNet, Subnets & Routing Module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security/                       # NSGs & Firewall Rule Module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── storage/                        # Azure Blob Storage & Private Endpoint Module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── backend/
    └── backend.tf.example              # Remote State Configuration Template
```

---

## 🚀 Quickstart Guide

### 1. Prerequisites
- [Terraform CLI `v1.5+`](https://developer.hashicorp.com/terraform/downloads) installed.
- [Azure CLI (`az`)](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) authenticated (`az login`).

### 2. Configure Local Variables

Copy the example variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your Azure region and naming prefixes:

```hcl
location            = "eastus"
environment         = "prod"
resource_group_name = "rg-landingzone-prod"
vnet_cidr           = "10.0.0.0/16"
```

### 3. Initialize & Preview

```bash
# Initialize Terraform modules & providers
terraform init

# Validate configuration syntax
terraform validate

# Perform a dry-run execution plan
terraform plan
```

### 4. Deploy Infrastructure

```bash
terraform apply -auto-approve
```

---

## 📜 License
Distributed under the **MIT License**. Free for public and commercial use.
