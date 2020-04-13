resource "aws_instance" "kafka_zk_cluster" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index)
  key_name               = var.key_name
  iam_instance_profile   = var.instance_profile
  vpc_security_group_ids = var.kafka_sg

  associate_public_ip_address = true

  tags = {
      Name = "Kafka-ZK-${count.index}"
  }

  root_block_device {
      volume_size = var.volume_size
  }   
}

resource "aws_eip" "elastic_ips" {
    vpc                 = true
    count               = var.instance_count
    instance            = aws_instance.kafka_zk_cluster[count.index].id
}
