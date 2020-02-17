output "public_ips" {
    value = values(aws_eip.elastic_ips)[*].public_ip
}