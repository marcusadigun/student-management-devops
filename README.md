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

📊 Observability & Monitoring
To ensure high availability and performance, the application includes a comprehensive local monitoring stack. This infrastructure allows for real-time tracking of container health, resource consumption, and potential memory leaks.

🛠 The Stack
Component,Function
Prometheus,Scrapes and stores time-series metrics from Docker containers every 15s.
Grafana,Visualizes metrics via interactive dashboards (CPU Load, Memory Usage, I/O).
cAdvisor,Google's container advisor; exposes raw resource usage data from the Docker engine.

🚀 How to Launch Mission Control
The monitoring stack is decoupled from the main application to ensure modularity.

Start the Monitoring Infrastructure:

Bash

cd monitoring
docker compose up -d
Access the Dashboards:

Grafana: http://localhost:3000 (Default: admin/admin)

Prometheus Targets: http://localhost:9090/targets

cAdvisor Stream: http://localhost:8081

View Real-Time Metrics:

CPU Speedometer: Tracks rate(container_cpu_usage_seconds_total) to identify CPU throttling.

Memory Health: Tracks container_memory_usage_bytes to detect potential memory leaks in the Python backend.

![Grafana Dashboard](https://github.com/user-attachments/assets/83591064-bafc-476e-860d-64609d5c8acb)


