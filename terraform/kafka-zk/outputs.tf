output "role_arn" {
    value = "${module.iam_role.kafka_instance_profile}"
}

output "kafka_cluster_ips" {
    value = "${module.kafka_cluster.public_ips}"
}