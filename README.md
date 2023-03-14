# Terraform Infrastructure
Web App infrastructure using Terraform provisioning tool 
The infrastructure is a three-tiered architecture that features the following :
-  VPC
- 6 subnets (2 public and 4 private) 
- A route table associated it with public subnets
- A route table associated it with private subnets
- Internet Gateway
- Public route in table, associated with the Internet Gateway. 
- Elastic IPs
- Nat Gateway
- Security Groups
- EC2 Instances for 2 webservers
- Launch Templates
- Target Groups
- Autoscaling Groups
- TLS Certificates
- Application Load Balancers (ALB)
- RDS
- DNS with Route53
<img title="a title" alt="Alt text" src="https://user-images.githubusercontent.com/74002629/197526138-6fc583b5-e963-45b3-8113-2c4163b98b16.PNG">
