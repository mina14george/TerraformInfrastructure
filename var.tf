# vpc vars
variable "region" {
        default = "us-east-1"
    }
variable "vpc_cidr" {
   default = "172.16.0.0/16"
    }

variable "enable_dns_support" {
    default = "true"
    }

variable "enable_dns_hostnames" {
    default ="true" 
    }

# subnet vars

variable "preferred_number_of_public_subnets" {
  default = 2
}
variable "preferred_number_of_private_subnets" {
  default = 4
}

variable "preferred_number_of_elastic_ip" {
  default = 2
}

# nat

variable "preferred_number_of_natgw" {
  default = 2
}

#route table

variable "public_route_table_cidr" {
  default = "0.0.0.0/0"
}

# alb
variable "ip_address_type" {
  default = "ipv4"
}

variable "load_balancer_type" {
 default =  "application"
}

# templates

variable "ami" {
  default = "ami-0aa7d40eeae50c9a9"
}

variable "keypair"{
  default = "GitLabRunnerVM"
}

# rds

variable "master-username" {
  default = "test"
}

variable "master-password" {
  default = "test1234"
}