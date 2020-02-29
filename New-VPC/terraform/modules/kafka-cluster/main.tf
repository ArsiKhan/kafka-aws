
data "aws_subnet_ids" "public_subnets" {
    vpc_id = "${var.vpc_id}"

    tags = {
        Name = "kafka-zk-vpc-public-*"
    }
}

resource "aws_instance" "kafka_zk_cluster" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  for_each               = data.aws_subnet_ids.public_subnets.ids
  subnet_id              = each.key
  key_name               = "${var.key_name}"
  iam_instance_profile   = "${var.instance_profile}"
  vpc_security_group_ids = "${var.kafka_sg}"

  associate_public_ip_address = true

  tags = {
      Name = "Kafka-ZK-${each.key}"
  }

  root_block_device {
      volume_size = "${var.volume_size}"
  }
   
}

resource "aws_eip" "elastic_ips" {
    vpc                 = true
    for_each            = aws_instance.kafka_zk_cluster
    instance            = aws_instance.kafka_zk_cluster[each.key].id
}
