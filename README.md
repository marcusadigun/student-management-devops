# HMS - Hostel Management System (Cloud-Native DevOps Edition) ☁️

## 🏗️ Architecture

This project deploys a production-grade, highly available **3-Tier Architecture** on AWS using modern DevOps practices. It transitions from local virtualization to cloud-native managed services.

- **Infrastructure as Code (IaC):** Terraform provisions the AWS VPC, EC2 instances, Security Groups, and RDS Database.
- **Configuration Management:** Ansible automates the software installation, Docker configuration, and Nginx setup.
- **Application Layer:** Dockerized Python (FastAPI) application running behind an Nginx Reverse Proxy.
- **Data Layer:** Managed AWS RDS (PostgreSQL) for persistence and reliability.

## 🛠️ Tech Stack

- **Cloud Provider:** AWS (us-east-1)
- **Infrastructure:** Terraform (HCL)
- **Configuration:** Ansible (YAML)
- **Containerization:** Docker & Docker Compose
- **Database:** AWS RDS (PostgreSQL 16.3)
- **Web Server:** Nginx (Reverse Proxy)
- **OS:** Ubuntu 22.04 LTS

## 🚀 Deployment Guide

### Prerequisites

- AWS Account & CLI configured
- Terraform installed
- Ansible installed
- SSH Key Pair

### 1. Provision Infrastructure (Terraform)

Build the cloud resources (Server + Database) in minutes.

```bash
cd terraform
# Initialize and Apply
terraform init
terraform apply -auto-approve
```
