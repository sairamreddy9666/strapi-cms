# 🚀 Strapi CMS Deployment Using Terraform & Docker (IaC)

This project demonstrates how to deploy **Strapi CMS** on an **AWS EC2 instance** using **Terraform (Infrastructure as Code)** and **Docker**, with full automation through a **user-data bootstrap script**.

The setup provisions the infrastructure and automatically installs Docker and runs Strapi on instance startup.

---

## 📌 Project Features

✔ Infrastructure as Code using Terraform  
✔ Automated EC2 provisioning on AWS  
✔ Docker-based Strapi deployment  
✔ User-data script for zero manual setup  
✔ SQLite database for quick testing  
✔ Persistent Docker volume for Strapi data  
✔ Fully reproducible deployment  

---

## 🗂️ Project Structure

```bash
strapi-cms/
├── ec2.tf              # EC2 instance resource
├── provider.tf         # AWS provider configuration
├── terraform.tfstate   # Terraform state file
├── user-data.sh        # Bootstrap script for Docker & Strapi
└── README.md           # Project documentation
```
---

## ⚙️ Prerequisites

Before you begin, ensure you have:

- AWS Account
- IAM User with EC2 & VPC permissions
- AWS Access Key & Secret Key configured
- Terraform installed
- An existing AWS Key Pair
- A Security Group allowing:
  - Port 22 (SSH)
  - Port 1337 (Strapi)

---

## 🖥️ Launch EC2 Instance & Setup Terraform

## ✅ Step 1: Launch EC2 t2.micro Instance

- Go to AWS EC2 Console

- Click Launch Instance

## ✅ Step 2: Install Terraform

- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

- terraform -version

## ✅ Step 3: Clone GitHub Repository

- git clone https://github.com/sairamreddy9666/strapi-cms.git

- cd strapi-cms

---

## 🔐 AWS Provider Configuration (provider.tf)
```
provider "aws" {
  region = "ap-south-1"
}
```
---

## 🖥️ EC2 Resource Configuration (ec2.tf)
```
resource "aws_instance" "strapi-server" {
  tags = {
    Name    = "strapi-server"
    project = "strapi"
  }

  ami               = "ami-0d176f79571d18a8f"
  instance_type     = "t2.micro"
  key_name          = "mumbai-kp"
  security_groups   = ["fst-sg"]
  user_data         = file("user-data.sh")
  count             = 1
  availability_zone = "ap-south-1a"

  root_block_device {
    volume_size = 20
  }
}
```
---

## 🐳 User Data Script (user-data.sh)

This script installs Docker and starts Strapi automatically when the instance boots.
```
#!/bin/bash
dnf update -y
dnf install docker -y
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

docker run -d \
  --name strapi \
  --restart unless-stopped \
  -p 1337:1337 \
  -e DATABASE_CLIENT=sqlite \
  -e DATABASE_FILENAME=/data/data.db \
  -v strapi-data:/data \
  strapi/strapi
```
---

## 🚀 Deployment Steps

## 1️⃣ Initialize Terraform
```
terraform init
```

## 2️⃣ Validate Configuration
```
terraform validate
```

## 3️⃣ Preview Resources
```
terraform plan
```

## 4️⃣ Deploy Infrastructure
```
terraform apply
```
---

## 🌐 Access Strapi Dashboard

Once deployment is complete, access Strapi in your browser:
```
http://<EC2-PUBLIC-IP>:1337/admin
```

Create your admin account and start building APIs immediately.

---

## 🗑️ Destroy Infrastructure (Cleanup)

To avoid AWS charges:
```
terraform destroy
```
---

## ✅ Output

- EC2 instance is automatically created

- Docker is installed automatically

- Strapi container runs automatically

- CMS is available publicly on port 1337

---

## 📚 Learning Outcomes

- Hands-on AWS EC2 provisioning with Terraform

- Real-world Infrastructure as Code implementation

- Automated Docker container deployment

- Cloud-native CMS hosting

- DevOps automation best practices

---

## 👨‍💻 Author

Sai Ram Reddy Badari

DevOps | Cloud | Automation

GitHub: https://github.com/sairamreddy9666

---
