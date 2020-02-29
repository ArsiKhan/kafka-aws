variable "vpc_id" {
    description = "VPC id for the Kafka-Zookeeper cluster"
}

variable "instance_profile" {
    description = "Instance profile for access to S3 bucket"
}

variable "ami_id" {
  description = "AMI-ID of the Kafka-Zookeeper Image" 
}

variable "instance_type" {
    description = "Instance Type for the Cluster Instances"
}

variable "key_name" {
    description = "PEM Key File name for SSH Access to the Instances"
}

variable "volume_size" {
    description = "Root volume size of the Instances"
}

variable "kafka_sg" {
    type        = list(string)
    description = "Security Group ID for attaching to the cluster"
}
