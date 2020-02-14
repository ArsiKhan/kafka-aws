module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "kafka-zk-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "kafka-zk"
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  
  bucket = "exhibitor-bucket-arsalan"
  acl    = "private"
  region = "us-east-1"
  versioning = {
    enabled = false
  }

}

module "iam_role" {
  source = "../modules/iam-role/"

  role_name = "kafka-zk"
  policy_name = "kafka-zk"
  s3_bucket_arn = "${module.s3_bucket.this_s3_bucket_arn}"
}