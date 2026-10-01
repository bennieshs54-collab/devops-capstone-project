📌 Project Overview

This project demonstrates the design and implementation of an end-to-end DevOps pipeline for deploying a containerized web application on AWS.

The main objective of this project is to automate the complete application delivery process — starting from source code management and testing, followed by Docker image creation, infrastructure provisioning, application deployment on Kubernetes, and finally monitoring the deployed application.

The project uses Jenkins as the CI/CD automation server, Terraform for Infrastructure as Code, Docker for containerization, Amazon ECR for container image storage, Amazon EKS for Kubernetes orchestration, Ansible for configuration management, and Prometheus with Grafana for monitoring.

The complete workflow is designed to reduce manual intervention and provide a repeatable deployment process.

🎯 Project Objectives

The major objectives of this project are:

Design a production-style AWS architecture for a containerized application.
Create and manage AWS infrastructure using Terraform.
Containerize the application using Docker.
Store and manage Docker images using Amazon ECR.
Deploy and run the application on Amazon EKS.
Automate CI/CD using Jenkins.
Use Ansible for configuration management.
Implement Kubernetes health checks and horizontal pod autoscaling.
Monitor application and infrastructure metrics using Prometheus and Grafana.
Store Terraform state remotely using Amazon S3.
Implement automated testing and deployment validation.
Document the complete implementation and troubleshooting process.
Follow basic security and cost-optimization practices.
🏗️ Architecture

The overall project architecture follows the flow below:

                         Developer
                            |
                            | Git Push
                            v
                    +----------------+
                    |    GitHub      |
                    | Source Code    |
                    +-------+--------+
                            |
                         Webhook
                            |
                            v
                    +----------------+
                    |    Jenkins     |
                    |   CI/CD Server  |
                    +-------+--------+
                            |
              +-------------+-------------+
              |             |             |
              v             v             v
          Automated      Docker        Terraform
           Testing        Build       Infrastructure
              |             |             |
              |             v             v
              |           ECR           AWS
              |             |             |
              |             +-------> EKS Cluster
              |                          |
              |                    +-----+-----+
              |                    |           |
              |                    v           v
              |                 Service     Pods
              |                    |           |
              |                    +-----+-----+
              |                          |
              |                    Load Balancer
              |                          |
              |                          v
              |                    Web Application
              |
              v
       Deployment Validation


                 EKS Monitoring
                       |
             +---------+---------+
             |                   |
             v                   v
        Prometheus             Grafana
             |                   |
             +---------+---------+
                       |
                  Dashboards
🛠️ Technologies Used
Technology	Purpose
AWS	Cloud infrastructure
Amazon VPC	Network architecture
Amazon EKS	Kubernetes cluster
Amazon ECR	Docker image registry
Amazon EC2	Jenkins server
Amazon S3	Terraform remote state
IAM	Access control
Terraform	Infrastructure as Code
Jenkins	CI/CD automation
Docker	Containerization
Kubernetes	Container orchestration
kubectl	Kubernetes management
Helm	Kubernetes package management
Ansible	Configuration management
Prometheus	Metrics collection
Grafana	Monitoring dashboards
Git	Version control
GitHub	Source code repository
📂 Repository Structure
devops-capstone-project/
│
├── application/
│   ├── src/
│   ├── tests/
│   ├── package.json
│   ├── package-lock.json
│   └── Dockerfile
│
├── docker/
│   └── docker-compose.yml
│
├── terraform/
│   ├── providers.tf
│   ├── versions.tf
│   ├── backend.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── vpc.tf
│   ├── eks.tf
│   ├── iam.tf
│   └── security-groups.tf
│
├── ansible/
│   ├── inventory/
│   │   └── hosts.ini
│   ├── playbook.yml
│   └── roles/
│
├── kubernetes/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── configmap.yaml
│   └── hpa.yaml
│
├── monitoring/
│   ├── prometheus/
│   └── grafana/
│
├── jenkins/
│   ├── Jenkinsfile
│   └── scripts/
│
├── tests/
│   ├── application-test.sh
│   └── deployment-test.sh
│
├── docs/
│   ├── architecture.md
│   ├── setup.md
│   ├── terraform.md
│   ├── jenkins.md
│   ├── kubernetes.md
│   ├── monitoring.md
│   └── troubleshooting.md
│
└── README.md
🔄 CI/CD Workflow

The CI/CD process implemented in this project follows the workflow below:

Developer
   |
   | Push code
   v
GitHub
   |
   | Webhook
   v
Jenkins
   |
   +----> Checkout Source
   |
   +----> Install Dependencies
   |
   +----> Run Tests
   |
   +----> Build Docker Image
   |
   +----> Authenticate with AWS ECR
   |
   +----> Push Image to ECR
   |
   +----> Deploy to EKS
   |
   +----> Verify Deployment
   |
   +----> Run Health Checks
   |
   v
Application Running on EKS

The goal is to make a code change flow through the pipeline without requiring manual Docker image creation or manual Kubernetes deployment.

🐳 Docker Implementation

The application is packaged into a Docker container so that the same application image can be used consistently across environments.

The Docker image contains:

Application source code
Required runtime
Application dependencies
Application configuration required at runtime

Build the image locally:

docker build -t devops-capstone-app:latest ./application

Run the application locally:

docker run -p 3000:3000 devops-capstone-app:latest

Test:

curl http://localhost:3000

Health endpoint:

curl http://localhost:3000/health
☁️ AWS Infrastructure

The infrastructure is provisioned using Terraform instead of manually creating every AWS resource through the AWS Console.

The main AWS components include:

VPC
├── Public Subnets
├── Private Subnets
├── Internet Gateway
├── NAT Gateway
└── Route Tables

EKS
├── EKS Control Plane
├── Managed Node Group
└── IAM Roles

ECR
└── Application Docker Image

EC2
└── Jenkins Server

S3
└── Terraform Remote State

This approach makes the infrastructure reproducible and easier to maintain.

🏗️ Terraform

Terraform is used to provision and manage the AWS infrastructure.

Before running Terraform, configure AWS CLI credentials or an appropriate IAM role.

Check AWS access:

aws sts get-caller-identity

Initialize Terraform:

cd terraform
terraform init

Validate the configuration:

terraform validate

Review the infrastructure plan:

terraform plan

Create the infrastructure:

terraform apply

After confirming the resources are no longer required, they can be removed using:

terraform destroy

terraform destroy should only be executed when the environment is no longer required.

🗄️ Terraform Remote State

Terraform state is stored remotely in Amazon S3.

The purpose of remote state is to:

Maintain the current infrastructure state.
Avoid depending on a local state file.
Provide centralized state management.
Support collaboration.
Reduce the possibility of losing the Terraform state.

Terraform state files and sensitive values are not committed to GitHub.

☸️ Kubernetes / Amazon EKS

Amazon EKS is used as the Kubernetes platform for running the application.

The application is deployed using Kubernetes resources including:

Namespace
Deployment
Service
ConfigMap
Horizontal Pod Autoscaler

Check the EKS nodes:

kubectl get nodes

Check application pods:

kubectl get pods

Check services:

kubectl get svc

Check deployments:

kubectl get deployments

Check HPA:

kubectl get hpa
🚀 Kubernetes Deployment

The application deployment is configured to run multiple replicas to improve availability.

Basic deployment flow:

Docker Image
     |
     v
Amazon ECR
     |
     v
Kubernetes Deployment
     |
     +------ Pod
     |
     +------ Pod
     |
     +------ Pod
     |
     v
Kubernetes Service
     |
     v
AWS Load Balancer

Application deployment:

kubectl apply -f kubernetes/

Verify:

kubectl get pods
❤️ Application Health Checks

The application exposes a health endpoint:

/health

Kubernetes uses health checks to determine whether the application is available and ready to receive traffic.

The deployment uses:

Liveness Probe

Used to determine whether the application container is still running correctly.

Readiness Probe

Used to determine whether the application is ready to receive traffic.

This helps Kubernetes remove unhealthy pods from service and restart containers when necessary.

📈 Horizontal Pod Autoscaling

The project uses Kubernetes Horizontal Pod Autoscaler to automatically adjust the number of application pods based on resource utilization.

Example configuration:

Minimum replicas: 2
Maximum replicas: 5
Target CPU utilization: 70%

Conceptually:

High CPU Usage
      |
      v
HPA detects increased utilization
      |
      v
More Pods
      |
      v
Application handles additional load

When the load decreases, Kubernetes can reduce the number of replicas within the configured limits.

⚙️ Ansible Configuration Management

Ansible is used for configuration management and server setup.

Terraform and Ansible have different responsibilities in this project.

Terraform

Terraform is responsible for creating infrastructure.

Terraform
   ↓
AWS Resources
Ansible

Ansible is responsible for configuring supported EC2/server environments.

Ansible
   ↓
Server Configuration
   ↓
Required Packages
   ↓
Required Tools

The Ansible playbooks are designed to automate repetitive configuration tasks instead of performing them manually.

🔧 Jenkins

Jenkins acts as the central CI/CD automation server.

The Jenkins server runs on an AWS EC2 instance.

The pipeline performs tasks such as:

Source Checkout
      ↓
Testing
      ↓
Docker Build
      ↓
ECR Push
      ↓
Kubernetes Deployment
      ↓
Deployment Verification

Jenkins is also integrated with the infrastructure automation workflow where required.

📋 Jenkins Pipeline Stages

The main application pipeline contains stages similar to:

1. Checkout
2. Install Dependencies
3. Test
4. Docker Build
5. ECR Login
6. Docker Push
7. Kubernetes Deployment
8. Rollout Verification
9. Health Check
10. Post Deployment Test

A successful pipeline indicates that the application has passed the required stages and has been deployed successfully.

🔐 Security

Security was considered throughout the implementation.

Some of the practices followed include:

IAM-based access control.
Least-privilege permissions wherever practical.
No AWS secret keys committed to GitHub.
Sensitive configuration kept outside source code.
.gitignore used for sensitive/local files.
Kubernetes resources isolated using namespaces.
Security groups used to control network access.
SSH access restricted to required sources.
Terraform state stored remotely rather than committed to the repository.

Example .gitignore entries:

.terraform/
*.tfstate
*.tfstate.*
*.pem
.env
.env.*
node_modules/
📊 Monitoring

Prometheus and Grafana are used for monitoring the Kubernetes environment and application.

The monitoring architecture is:

Kubernetes / Application
          |
          v
      Prometheus
          |
          v
       Grafana
          |
          v
      Dashboards

Prometheus collects metrics from the environment.

Grafana is used to visualize these metrics through dashboards.

📈 Grafana Dashboard

The monitoring dashboard can be used to observe information such as:

CPU utilization
Memory utilization
Pod status
Pod count
Node status
Container resource usage
Pod restarts
Kubernetes resource health

Screenshots of the working Grafana dashboard are included in the project documentation.

🧪 Testing

Testing is performed at different levels.

Application Testing
curl http://localhost:3000

Health check:

curl http://localhost:3000/health
Docker Testing
docker ps
docker images
Kubernetes Testing
kubectl get nodes
kubectl get pods
kubectl get svc
kubectl get deployments
kubectl get hpa
Deployment Verification
kubectl rollout status deployment/<deployment-name>
Application Test Through Load Balancer

After the AWS Load Balancer is provisioned:

http://<LOAD-BALANCER-DNS>

The application response is verified from outside the Kubernetes cluster.

💰 Cost Optimization

Since this project is implemented as a learning/capstone environment, controlling AWS costs is important.

The following practices are considered:

Use appropriately sized EC2 instances.
Avoid unnecessary resources.
Delete unused environments.
Remove unused ECR images.
Monitor AWS billing and usage.
Use Terraform to consistently create and remove infrastructure.
Avoid leaving development infrastructure running when it is not required.
Review load balancers, NAT gateways, EC2 instances and EKS resources regularly.

AWS Budgets can also be configured to provide cost notifications.

🔍 Troubleshooting

Some common troubleshooting commands used during implementation are:

Check AWS identity
aws sts get-caller-identity
Check EKS nodes
kubectl get nodes
Check pods
kubectl get pods -A
Check pod logs
kubectl logs <pod-name>
Describe a pod
kubectl describe pod <pod-name>
Check services
kubectl get svc
Check deployments
kubectl get deployments
Check HPA
kubectl get hpa
Check Terraform
terraform validate
terraform plan
📸 Project Screenshots

The following screenshots are maintained under the project documentation:

docs/screenshots/

Important evidence includes:

GitHub repository
Jenkins dashboard
Successful Jenkins pipeline
Docker image
Amazon ECR repository
Terraform execution
AWS VPC
EKS cluster
Kubernetes nodes
Kubernetes pods
Kubernetes service
Application running through Load Balancer
HPA
Prometheus
Grafana dashboard

These screenshots provide implementation evidence for the project.

📚 Key DevOps Concepts Demonstrated

Through this project, I worked with and implemented the following concepts:

Version Control
Git branching and commits
GitHub integration
Continuous Integration
Continuous Deployment
Infrastructure as Code
AWS networking
IAM
Docker containerization
Container image management
Kubernetes orchestration
Amazon EKS
Amazon ECR
Kubernetes Services
Kubernetes health checks
Horizontal Pod Autoscaling
Configuration Management
Jenkins pipelines
Terraform remote state
Monitoring
Prometheus
Grafana
Cloud cost optimization
Deployment troubleshooting
🎓 Learning Outcomes

This capstone project helped me understand how different DevOps tools work together instead of using each tool independently.

The most important part of the project was understanding the complete flow:

Code
 ↓
GitHub
 ↓
Jenkins
 ↓
Test
 ↓
Docker
 ↓
Amazon ECR
 ↓
Amazon EKS
 ↓
Kubernetes
 ↓
Load Balancer
 ↓
Application
 ↓
Prometheus
 ↓
Grafana

I also gained practical experience in infrastructure automation, troubleshooting failed deployments, understanding AWS networking, managing Kubernetes workloads, and building repeatable deployment workflows.

🚀 Future Improvements

The current implementation can be extended further with:

Blue/Green deployments
Canary deployments
Automated security scanning
SonarQube code-quality checks
Trivy container vulnerability scanning
HTTPS using AWS Certificate Manager
Route 53 domain integration
Centralized logging
ELK/OpenSearch
Kubernetes Network Policies
Secrets management using AWS Secrets Manager
Multi-environment deployment
Development, staging and production environments
Disaster recovery architecture
Multi-cloud deployment using Azure or other cloud providers
📌 Project Status
Project Type       : DevOps Capstone Project
Cloud Platform     : AWS
CI/CD               : Jenkins
Containerization   : Docker
Container Registry : Amazon ECR
Orchestration      : Kubernetes / Amazon EKS
IaC                : Terraform
Configuration Mgmt : Ansible
Monitoring         : Prometheus + Grafana
Source Control     : Git + GitHub
Status             : Completed
👨‍💻 Author

Benniesh S

DevOps / Cloud Engineering Learner

This project was developed as part of my hands-on DevOps and Cloud learning journey, with the objective of understanding and implementing a complete CI/CD workflow using AWS and open-source DevOps tools.
