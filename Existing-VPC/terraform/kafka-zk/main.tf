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
  vpc_id       = var.vpc_id

}

module "kafka_cluster" {
  source = "../../../modules/kafka-cluster/"

  subnet_ids       = [var.subnet_id_0, var.subnet_id_1, var.subnet_id_2]  
  kafka_sg         = [module.kafka_sg.kafka_sg_id]
  instance_profile = module.iam_role.kafka_instance_profile
  instance_count   = var.instance_count
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_name         = var.key_name
  volume_size      = var.root_volume_size
}