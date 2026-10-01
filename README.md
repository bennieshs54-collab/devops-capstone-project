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

curl http://15.252.144.112:3000

Health endpoint:

curl http://15.252.144.112:3000/health
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

<img width="940" height="293" alt="image" src="https://github.com/user-attachments/assets/bf17a87b-5a2f-4c6c-a13b-27b52fed56aa" />

<img width="940" height="395" alt="image" src="https://github.com/user-attachments/assets/3dde744f-a64a-4794-94af-a3603f1a9c0c" />

<img width="940" height="525" alt="image" src="https://github.com/user-attachments/assets/5d43d418-1e44-4e62-ac65-cdc6ed60503d" />

<img width="940" height="544" alt="image" src="https://github.com/user-attachments/assets/94d5f682-1432-4c5b-95ed-3c61303f32f3" />

<img width="940" height="684" alt="image" src="https://github.com/user-attachments/assets/b42f27eb-26a1-4fb9-9e87-c61d8ac97f62" />

<img width="940" height="331" alt="image" src="https://github.com/user-attachments/assets/60e0b9b4-c674-4894-9f2d-6f018f14554a" />

<img width="940" height="400" alt="image" src="https://github.com/user-attachments/assets/f9aea607-e6b9-4f30-a8a2-f35990fb75a9" />

<img width="940" height="507" alt="image" src="https://github.com/user-attachments/assets/423b84a0-d204-4e02-b7e1-c805b1609ac7" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/1b62ee54-94dd-4bfc-bc93-ad718546342f" />

<img width="940" height="283" alt="image" src="https://github.com/user-attachments/assets/9ca58fc2-2116-4588-9ea5-1b620514cffd" />

<img width="940" height="238" alt="image" src="https://github.com/user-attachments/assets/b7ee7bfe-14a4-4c84-acf0-68b3ec638037" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/ef43fe5e-fabd-4189-a957-ee021d02f6e6" />

<img width="940" height="395" alt="image" src="https://github.com/user-attachments/assets/b141e222-0156-4ce1-9592-a4c876bfeb30" />

<img width="940" height="352" alt="image" src="https://github.com/user-attachments/assets/955249b2-d625-4b45-9eaf-4684ec1e7ed9" />

<img width="940" height="506" alt="image" src="https://github.com/user-attachments/assets/1606de27-5eca-475b-86f9-3c8c7efa91a1" />

<img width="940" height="239" alt="image" src="https://github.com/user-attachments/assets/be951803-79f6-4a23-978d-c20a0179b7cb" />

<img width="940" height="432" alt="image" src="https://github.com/user-attachments/assets/b72c2dc0-3c91-41c2-9082-d76af1073908" />

<img width="940" height="175" alt="image" src="https://github.com/user-attachments/assets/0072160a-d9fd-45da-96ef-f0dea2fbbaeb" />

<img width="940" height="393" alt="image" src="https://github.com/user-attachments/assets/c224495f-598f-43e7-a662-b0dddd5502e3" />

<img width="940" height="456" alt="image" src="https://github.com/user-attachments/assets/79ca4e87-ead5-40a4-8aa9-e3e644c8936a" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/7ed6e5dc-a1c8-494c-bccf-82fa606a9dd9" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/4d95839d-f3ad-4f19-95c1-e622c7c5a3ae" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/acd6ffee-afe5-4486-8b45-4906026f801f" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/d9bb9bdb-6741-4086-8bec-4a411cbbf47c" />

<img width="940" height="530" alt="image" src="https://github.com/user-attachments/assets/217fd359-d5cd-4f4f-8c68-dbe90d01de16" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/146f8fd7-5ec8-4da4-a171-fa2f5276cb13" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/1124a770-e79d-49a9-be7a-60982a24d83b" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/c065bc8c-8537-4ae2-9c6a-b7acbe2a921a" />

<img width="940" height="528" alt="image" src="https://github.com/user-attachments/assets/92aca028-f662-4497-921e-74c05b3ff051" />

<img width="940" height="509" alt="image" src="https://github.com/user-attachments/assets/1de20989-994d-4478-a85e-a53885b89a42" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/1916d122-7737-49c4-8404-23c50481e5c7" />

<img width="940" height="195" alt="image" src="https://github.com/user-attachments/assets/32de0492-e043-4eac-a6ac-feddaa38efb6" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/03fdf401-dc45-4eae-9fcc-86844b035ebb" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/aab678ca-d1d1-4cb0-95e4-936c55a55e63" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/82a44f94-757b-4d65-8f27-d5ce36cecedd" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/3d22cdd8-0599-457e-b4fb-a025e774e3dc" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/7666799c-a9a6-41ef-8e0d-cdcf930f4301" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/64d2f646-80d7-44a3-9b9f-3f419ce63359" />

<img width="940" height="508" alt="image" src="https://github.com/user-attachments/assets/b7431a6b-650b-4970-8a2c-9b6bc7fa9112" />

<img width="940" height="504" alt="image" src="https://github.com/user-attachments/assets/4f02b69e-2473-43fb-823e-93636d430e56" />

<img width="940" height="501" alt="image" src="https://github.com/user-attachments/assets/de3eff17-48b0-464a-bae1-caa8e8fd92a2" />

<img width="940" height="509" alt="image" src="https://github.com/user-attachments/assets/672ff4c6-79be-4e0b-b70c-29323c549380" />

<img width="940" height="528" alt="image" src="https://github.com/user-attachments/assets/8bc8f6bb-f83e-4ea1-8c59-ebebb270e4db" />

<img width="940" height="502" alt="image" src="https://github.com/user-attachments/assets/4cf5b028-9e4a-46df-bf72-eb313f53158c" />

<img width="940" height="481" alt="image" src="https://github.com/user-attachments/assets/1f37d6f0-d84e-4a11-8ca3-8b53e0b21b67" />

<img width="940" height="484" alt="image" src="https://github.com/user-attachments/assets/46d51642-2b85-4e39-b32c-fa9ee7f72d46" />

<img width="940" height="503" alt="image" src="https://github.com/user-attachments/assets/3959255b-db6e-4ec8-9b6c-df5e136ae59f" />

<img width="940" height="476" alt="image" src="https://github.com/user-attachments/assets/8355180a-3932-4d7e-9ae9-3307a91df6a5" />

<img width="940" height="500" alt="image" src="https://github.com/user-attachments/assets/4f7af3a2-20fd-41d4-b272-f9ce86b8951d" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/a4062703-587a-447e-8e94-038ffe67deb3" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/dbf66117-1479-42c1-aadc-ec13f2029a57" />

<img width="940" height="338" alt="image" src="https://github.com/user-attachments/assets/fea11bdc-36a9-43e0-943a-8b615f7127e7" />

<img width="940" height="500" alt="image" src="https://github.com/user-attachments/assets/0695d555-4a35-4108-8c30-18510962cc8d" />

<img width="940" height="89" alt="image" src="https://github.com/user-attachments/assets/3be75146-573d-4c0d-8d0e-1ac72b6214dd" />

<img width="940" height="120" alt="image" src="https://github.com/user-attachments/assets/6a84cd80-050b-42a7-b216-b24501eb4a2c" />

<img width="940" height="478" alt="image" src="https://github.com/user-attachments/assets/92dc8c35-24f9-4a05-843c-a4656967f17a" />

<img width="940" height="527" alt="image" src="https://github.com/user-attachments/assets/19d14fad-69d4-4887-b042-386c06a237a2" />

<img width="940" height="513" alt="image" src="https://github.com/user-attachments/assets/cecefcc6-5286-4957-b3db-93ddfdc461e7" />

<img width="940" height="506" alt="image" src="https://github.com/user-attachments/assets/e98ec1db-5856-4fec-bcf4-abc62356c318" />

<img width="940" height="503" alt="image" src="https://github.com/user-attachments/assets/93e9731f-554b-4830-9c48-87efb60f71fd" />

<img width="940" height="130" alt="image" src="https://github.com/user-attachments/assets/ade0fb25-2265-421a-84b4-f78618b80299" />

<img width="940" height="508" alt="image" src="https://github.com/user-attachments/assets/62dbd096-9560-4584-a522-fff14ed7e247" />

<img width="940" height="506" alt="image" src="https://github.com/user-attachments/assets/8ad843a5-d9f4-4b7c-817d-474ffbb01fb0" />

<img width="940" height="503" alt="image" src="https://github.com/user-attachments/assets/84a84c28-3f3a-4e20-a94e-f6975fcd9a7b" />

<img width="940" height="528" alt="image" src="https://github.com/user-attachments/assets/618c7078-dfb7-47a4-ab9d-ca501e743390" />

<img width="940" height="499" alt="image" src="https://github.com/user-attachments/assets/b9eb19d4-633d-41a2-bcd8-c02d4b867cd1" />

<img width="940" height="499" alt="image" src="https://github.com/user-attachments/assets/1a8c4211-d82f-4fb4-a9f1-a59426331af3" />

<img width="940" height="234" alt="image" src="https://github.com/user-attachments/assets/35327129-1cee-4b99-a721-40d0c7b047bc" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/8f7424ae-c770-4135-9a23-721925b2a2b5" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/1acc4544-899d-44d2-b0d8-3ec2f3f4080f" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/b4fcef04-7aaf-47b1-895e-dd818062d5ec" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/fd4ce9d3-c9ca-45ed-805f-520dac0f9e25" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/37c2eb3f-a8c7-4167-ab30-f946faa725b0" />

<img width="940" height="529" alt="image" src="https://github.com/user-attachments/assets/a9fab490-2800-4976-b42c-5ef3062ed216" />

<img width="940" height="288" alt="image" src="https://github.com/usr-attachments/assets/6a6f0002-bb51-4abf-9014-fb02334260ae" />

<img width="940" height="537" alt="image" src="https://github.com/user-attachments/assets/36f39bbb-fd4f-42aa-87c1-fb8439edf7b4" />

<img width="940" height="528" alt="image" src="https://github.com/user-attachments/assets/4db00c0e-5c9e-4e1a-a1e5-c7176c284867" />

<img width="940" height="530" alt="image" src="https://github.com/user-attachments/assets/3a6a80cc-e21d-48e9-9fd2-c1faff91b6f0" />



















































































