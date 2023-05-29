variable "Landmarktechvpc" {
    default = "Landmarktechvpc"
    description = "The VPC name"
}
variable "VPCName" {
    default = "Landmarktechvpc"
    description = "The VPC name"
}

variable "Landmarktechvpccidr" {
    default = "10.0.0.0/16"
    description = "The CIDR block for the custom VPC"
}

variable "PublicSubnet1_CIDR" {
    default = "10.0.1.0/24"
    description = "CIDR block for Public Subnet 1"
}


variable "PublicSubnet2_CIDR" {
    default = "10.0.2.0/24"
    description = "CIDR block for Public Subnet 2"
}

variable "PrivateSubnet1_CIDR" {
    default = "10.0.11.0/24"
    description = "CIDR block for Private Subnet 1"
}

variable "PrivateSubnet2_CIDR" {
    default = "10.0.12.0/24"
    description = "CIDR block for Private Subnet 2"
}

variable "PrivateSubnet3_CIDR" {
    default = "10.0.13.0/24"
    description = "CIDR block for Private Subnet 3"
}

variable "PrivateSubnet4_CIDR" {
    default = "10.0.14.0/24"
    description = "CIDR block for Private Subnet 4"
}

variable "ApplicationLoadBalancer" {
    default = "LabVPCALB"
    description = "Application load balancer"
}

variable "all_IPs" {
    default = "0.0.0.0/0"
    description = "All IPs on the internet"
}

variable "igw" {
    default = "LabVPCInternetGateway"
    description = "The Internet Gateway for the VPC"
}

variable "nat_gw" {
    default = "LabVPCNATGateway"
    description = "NAT Gateway for Private Subnet"
}

variable "eip" {
    default = "LandmarktechEIP"
    description = "Elastic IP for NAT Gateway"
}

variable "nat_gw2" {
    default = "LandmarktechNATGateway2"
    description = "NAT Gateway for Private Subnet"
}

variable "eip2" {
    default = "LandmarktechEIP2"
    description = "Elastic IP for NAT Gateway"
}

variable "instancetype" {
    default = "t3.micro"
    description = "Instance type for the application server"
}

variable "region" {
    default = "us-east-1"
    description = "the region to provision resources in"
}

variable "access_key" {
    default = "AKIA5FQX4UVK"
    description = "access_key for our region "
}

variable "secret_key" {
    default = "B9ZD9e8C/gb9XoIZCT"
    description = "secret_key for our region "
}
