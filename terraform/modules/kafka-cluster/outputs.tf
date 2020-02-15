output "public_ips" {
    value = values(aws_instance.kafka_zk_cluster)[*].public_ip
}