# variables.tf

variable "aws_region" {
  description = "AWS region where resources will be created."
  type        = string
  default     = "us-east-1" # Change to your desired region
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16" # Change to your desired CIDR block
}

variable "subnet1_cidr_block" {
  description = "CIDR block for subnet 1."
  type        = string
  default     = "10.0.1.0/24" # Change to your desired CIDR block for subnet 1
}

variable "subnet2_cidr_block" {
  description = "CIDR block for subnet 2."
  type        = string
  default     = "10.0.2.0/24" # Change to your desired CIDR block for subnet 2
}

variable "availability_zone1" {
  description = "Availability Zone for subnet 1."
  type        = string
  default     = "us-east-1a" # Change to your desired Availability Zone for subnet 1
}

variable "availability_zone2" {
  description = "Availability Zone for subnet 2."
  type        = string
  default     = "us-east-1b" # Change to your desired Availability Zone for subnet 2
}

# variable "ecs_cluster_name_subnet1" {
#   description = "Name of the ECS Cluster in subnet 1."
#   type        = string
#   default     = "ecs-cluster-subnet1" # Change to your desired name for ECS Cluster in subnet 1
# }

# variable "ecs_cluster_name_subnet2" {
#   description = "Name of the ECS Cluster in subnet 2."
#   type        = string
#   default     = "ecs-cluster-subnet2" # Change to your desired name for ECS Cluster in subnet 2
# }