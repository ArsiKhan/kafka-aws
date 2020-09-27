output "public_ips" {
    value = module.kafka_cluster.public_ips
}

output "private_ips" {
    value = module.kafka_cluster.private_ips
}
output "vpc_name" {
  value = module.vpc.vpc_id
}

output "exhibitor_s3_bucket" {
  value = module.s3_bucket.this_s3_bucket_id
}

resource "local_file" "Ansible-Inventory" {
    content = templatefile("inventory.tmpl",
    {
        ansible_host = module.kafka_cluster.public_ips,
        private_ip   = module.kafka_cluster.private_ips
    })
    filename = "../../ansible/dyn_inven"
}