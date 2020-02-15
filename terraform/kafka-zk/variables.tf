variable "my_public_ip" {
  default = ["195.246.242.219/32"]
}

variable "ami_id" {
    default = "ami-0666668af65484641"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "key_name" {
    default = "kafka-zookeeper-cluster"
}

variable "volume_size" {
    default = "8"  
}
