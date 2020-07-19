data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "kafka-zk-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  public_subnets  = [var.subnet_0, var.subnet_1, var.subnet_2]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  
  bucket = "${var.s3_bucket_name}-${random_string.random.result}"
  acl    = "private"
  region = var.region

  versioning = {
    enabled = false
  }
  
  force_destroy = true

}

module "iam_role" {
  source = "../../../modules/iam-role/"

  role_name             = "${var.environment}-role"
  instance_profile_name = "${var.environment}-profile"
  policy_name           = "${var.environment}-policy"
  s3_bucket_arn         = module.s3_bucket.this_s3_bucket_arn
}

module "kafka_sg" {
  source = "../../../modules/kafka-cluster-securitygroup"

  my_public_ip = var.my_public_ip
  vpc_id       = module.vpc.vpc_id
}

module "kafka_cluster" {
  source = "../../../modules/kafka-cluster/"

  subnet_ids       = module.vpc.public_subnets
  kafka_sg         = [module.kafka_sg.kafka_sg_id]
  instance_profile = module.iam_role.kafka_instance_profile
  instance_count   = var.instance_count
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_name         = var.key_name
  volume_size      = var.root_volume_size
}