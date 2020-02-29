output "kafka_cluster_ips" {
    value = "${module.kafka_cluster.public_ips}"
}

output "kafka_cluster_private_ips" {
    value = "${module.kafka_cluster.private_ips}"
}

output "exhibitor_s3_bucket" {
  value = "${var.s3_bucket_name}"
}
