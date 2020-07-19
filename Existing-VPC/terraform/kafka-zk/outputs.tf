output "public_ips" {
    value = module.kafka_cluster.public_ips
}

output "private_ips" {
    value = module.kafka_cluster.private_ips
}

output "exhibitor_s3_bucket" {
  value = module.s3_bucket.this_s3_bucket_id
}
