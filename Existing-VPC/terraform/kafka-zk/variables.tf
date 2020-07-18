
variable "region" {
    default = "us-east-1"
}

variable "vpc_id" {
    default = "vpc-6096e01a"
}

variable "subnet_id_0" {
    default = "subnet-01a0fa66"
}

variable "subnet_id_1" {
    default = "subnet-1f5c4310"
}

variable "subnet_id_2" {
    default = "subnet-30a6537d"
}

variable "s3_bucket_name" {
    default = "exhibitor-bucket-arsalan"
}

variable "environment" {
    default     = "us-west-2"
    description = "Name of Environment to append"
}

variable "my_public_ip" {
   default     = "117.20.31.76/32"
   description = "Public Ip for adding in the security Groups"
}

variable "instance_count" {
    default     = 1
    description = "Number of Kafka Instances in the Cluster"
}

variable "ami_id" {
    default     = "ami-0931d12fefe6f20a4"
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
