output "public_ips" {
    value = aws_eip.elastic_ips[*].public_ip
}

output "private_ips" {
    value = aws_eip.elastic_ips[*].private_ip
}