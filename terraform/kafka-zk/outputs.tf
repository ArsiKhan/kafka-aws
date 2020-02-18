output "kafka_cluster_ips" {
    value = "${module.kafka_cluster.public_ips}"
}

output "kafka_cluster_private_ips" {
    value = "${module.kafka_cluster.private_ips}"
}
output "vpc_name" {
  value = "${module.vpc.vpc_id}"
}

