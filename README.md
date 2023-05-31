# Building a 3-Tier Architecture for in AWS using Terraform

In this project, we will build a the architecture for a web app in AWS. 

The main.tf files contains almost all the configuration needed to provision the infrastructure.

To kick if off, add or export your AWS CLI credentials and run the following commands from your terminal

terraform init

terraform plan --var-file=testing.tfvars

terraform apply --var-file=testing.tfvars


https://medium.com/@emmanuelibok505/build-a-three-tier-web-application-using-terraform-d3bad86435ce
