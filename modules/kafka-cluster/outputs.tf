output "public_ips" {
    value = aws_instance.kafka_zk_cluster[*].public_ip
}

output "private_ips" {
    value = aws_instance.kafka_zk_cluster[*].private_ip
}