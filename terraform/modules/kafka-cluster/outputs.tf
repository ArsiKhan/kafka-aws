output "public_ips" {
    value = values(aws_eip.elastic_ips)[*].public_ip
}

output "private_ips" {
    value = values(aws_instance.kafka_zk_cluster)[*].private_ip
}