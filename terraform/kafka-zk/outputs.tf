output "kafka_cluster_ips" {
    value = "${module.kafka_cluster.public_ips}"
}