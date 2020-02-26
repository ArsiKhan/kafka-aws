
variable "region" {
    default = "us-west-2"
}

variable "s3_bucket_name" {
    default = "exhibitor-bucket-arsalan"
}

variable "environment" {
    default     = "us-west-2"
    description = "Name of Environment to append"
}

variable "my_public_ip" {
   default     = ["117.20.31.76/32"]
   description = "Public Ip for adding in the security Groups"
}

variable "ami_id" {
    default     = "ami-0d68af8d1af1cae8c"
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

variable "volume_size" {
    default     = "20"
    description = "Volume Size of the EBS attached to the Cluster"  
}
