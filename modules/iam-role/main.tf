resource "aws_iam_role" "kafka_zk_role" {
  name = var.role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [    
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "kafka_instance_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.kafka_zk_role.name
}

resource "aws_iam_role_policy" "kafka_policy" {
  name = var.policy_name
  role = aws_iam_role.kafka_zk_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListObjectsInBucket",
            "Effect": "Allow",
            "Action": ["s3:ListBucket"],
            "Resource": ["${var.s3_bucket_arn}"]
        },
        {
            "Sid": "AllObjectActions",
            "Effect": "Allow",
            "Action": "s3:*Object",
            "Resource": ["${var.s3_bucket_arn}/*"]
        }
    ]
}
EOF

}