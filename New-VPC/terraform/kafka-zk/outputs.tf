output "public_ips" {
    value = "${module.kafka_cluster.public_ips}"
}

output "private_ips" {
    value = "${module.kafka_cluster.private_ips}"
}
output "vpc_name" {
  value = "${module.vpc.vpc_id}"
}

output "exhibitor_s3_bucket" {
  value = "${var.s3_bucket_name}"
}
