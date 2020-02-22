
variable "region" {
    default = "us-east-1"
}

variable "s3_bucket_name" {
    default = "exhibitor-bucket-arsalan"
}

variable "environment" {
    default = "kafka-zk"
}

variable "my_public_ip" {
   default = ["196.246.240.190/32"]
}

variable "ami_id" {
    default = "ami-0452c13d63e5e3449"
}

variable "instance_type" {
    default = "t2.medium"
}

variable "key_name" {
    default = "kafka-zookeeper-cluster"
}

variable "volume_size" {
    default = "20"  
}
