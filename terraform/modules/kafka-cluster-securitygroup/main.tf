
resource "aws_security_group" "kafka_cluster_sg" {
  name        = "kafka-security-group"
  description = "Allow kafka zookeeper traffic"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "kafka-security-group"
  }
}

resource "aws_security_group_rule" "allow_kafka_port_peers" {
  type      = "ingress"
  from_port = "9092"
  to_port   = "9092"
  protocol  = "tcp"
  self      = true

  security_group_id = "${aws_security_group.kafka_cluster_sg.id}"
}

resource "aws_security_group_rule" "allow_zookeeper_port_peers" {
  type      = "ingress"
  from_port = "2181"
  to_port   = "2181"
  protocol  = "tcp"
  self      = true

  security_group_id = "${aws_security_group.kafka_cluster_sg.id}"
}

resource "aws_security_group_rule" "allow_exhibitor_peers" {
  type        = "ingress"
  from_port   = "8181"
  to_port     = "8181"
  protocol    = "tcp"
  self        = true

  security_group_id = "${aws_security_group.kafka_cluster_sg.id}"
}

resource "aws_security_group_rule" "allow_exhibitor_outside" {
  type        = "ingress"
  from_port   = "8181"
  to_port     = "8181"
  protocol    = "tcp"
  cidr_blocks = "${var.my_public_ip}"

  security_group_id = "${aws_security_group.kafka_cluster_sg.id}"
}

resource "aws_security_group_rule" "cluster_peers" {
  type      = "ingress"
  from_port = "2888"
  to_port   = "3888"
  protocol  = "tcp"
  self      = true

  security_group_id = "${aws_security_group.kafka_cluster_sg.id}"
}

resource "aws_security_group_rule" "allow_ssh" {
  type        = "ingress"
  from_port   = "22"
  to_port     = "22"
  protocol    = "tcp"
  cidr_blocks = "${var.my_public_ip}"

  security_group_id = "${aws_security_group.kafka_cluster_sg.id}"
}


resource "aws_security_group_rule" "allow_ssh_10p" {
  type        = "ingress"
  from_port   = "22"
  to_port     = "22"
  protocol    = "tcp"
  cidr_blocks = ["117.20.31.76/32"]

  security_group_id = "${aws_security_group.kafka_cluster_sg.id}"
}