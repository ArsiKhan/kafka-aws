variable "role_name" {
  description = "Name of IAM role to create"
}

variable "instance_profile_name" {
  description = "Name of IAM instance profile"
}

variable "policy_name" {
  description = "Name of IAM Policy to create"
}

variable "s3_bucket_arn" {
  description = "S3 bucket ARN on which we need access"
}
