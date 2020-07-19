
variable "region" {
    default = "us-east-1"
}

variable "s3_bucket_name" {
    default = "exhibitor-bucket"
}

variable "environment" {
    default     = "DEV"
    description = "Name of Environment to append"
}

variable "vpc_cidr" {
    default  = "10.0.0.0/16"
    description = "Cidr block for VPC"
}

variable "subnet_0" {
    default = "10.0.101.0/24"
    description = "Cidr block for first subnet"
}

variable "subnet_1" {
    default = "10.0.102.0/24"
    description = "Cidr block for second subnet"
}

variable "subnet_2" {
    default     = "10.0.103.0/24"
    description = "Cidr block for third subnet"
}

variable "my_public_ip" {
   default     = "1.1.1.1/32"
   description = "Public Ip for adding in the security Groups"
}

variable "instance_count" {
    default     = 1
    description = "Number of Kafka Instances in the Cluster"
}

variable "ami_id" {
    default     = "ami-09854928f5c932aab"
    description = "Base Image ID for the Cluster"
}

variable "instance_type" {
    default     = "t2.medium"
    description = "Instance Type for each of the Nodes in the Cluster"
}

variable "key_name" {
    default     = "kafka-zk-key"
    description = "Private Key File name for the SSH Access to the Cluster"
}

variable "root_volume_size" {
    default     = "20"
    description = "Volume Size of the EBS attached to the Cluster"  
}
