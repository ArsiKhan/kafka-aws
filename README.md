# Multi-Broker HA Kafka Cluster in AWS

This Packer, Ansible, Docker and Terraform code can be used to instantiate your Kafka Cluster in AWS with its own Zookeeper cluster.

## Getting Started

These instructions will get you a copy of the infrastructure up and running on your AWS account.

### Prerequisites

* AWS-Cli
* Packer
* Ansible-2.8
* Terraform v0.12.20 or above
* AWS account with an IAM user having appropriate permissions

Installing Ansible 2.8 on a Ubuntu 18.04 machine
```
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository ppa:ansible/ansible-2.8
sudo apt-get install ansible=2.8.8-1ppa~bionic
```
Installing Ansible 2.8 using pip
```
pip install ansible==2.8.0
```

### Underlying Concept

The idea here is that we'll be first creating an AMI with [Packer](https://packer.io/) using the [Ansible provisioner](https://packer.io/docs/provisioners/ansible.html) having  Kafka and Scala bundled inside a docker container on the Machine Image.

Once the image is created we'll be calling another Ansible script which uses [Terraform](https://docs.ansible.com/ansible/latest/modules/terraform_module.html) module to provision the AWS Infrastructure. The module provisions virtual machines or cloud instances, and then we hand over the reins to Ansible again to finish up the configuration of our OS and Kafka Cluster.

### Building the Golden Image
Clone the repository on your local machine with all the pre-requisites installed.

The easiest way to use AWS credentials is creating a profile and exporting the profile name as an environment variable.

```
$ aws configure --profile <name of your profile>
AWS Access Key ID [None]: *****************
AWS Secret Access Key [None]: *******************
Default region name [None]: us-east-1
Default output format [None]:

$ export AWS_PROFILE=<name of your profile>
```
Browse to the directory with packer manifests
```
$ cd packer
```


Open the variables.json file and add the variables for the version and region in which you need to create the AMI.

```
{
    "aws_region": "us-west-2",
    "ami_name": "KAFKA_AMI",
    "kafka_version": "0.8.2.0",
    "scala_version": "2.9.1"
}
```
Run the following command for creating an AMI with the appropriate version of Kafka and Zookeeper installed

```
$ packer build -var-file=variables.json packer.json
```
Note the AMI-ID as this would be required in the next step.
## Cluster Variables

Open the external_var.yml.
```
$ nano ../ansible/vars/external_vars.yml
```
### Things to note
* For using Existing-VPC deployment there must be 3 subnet ids provided in the variables file.
* For using New-VPC 3 subnet cidr blocks must be provided.
```
region: "us-west-2"
s3_bucket_name: "exhibitor-bucket"
environment_name: "kafka-zk"
my_public_ip: "1.1.1.1/1"
ami_id: "ami-0f7d1218068eef0e2"
instance_type: "t2.medium"
key_name: "kafka-zookeeper-cluster"
volume_size: "20"
```

## Deployment

Browse to the ansible directory and run the ansible playbook command
```
$ cd ../ansible
$ ansible-playbook -i dyn_inven terraform.yaml
```

## Built With

* [Packer](https://www.packer.io/docs) - The EBS image builder
* [Docker](https://docs.docker.com/) - Kafka and Zookeeper libraries packer
* [Terraform](https://www.terraform.io/docs/index.html) - Used to Provision the underlying infrastructure on AWS
* [Ansible](https://docs.ansible.com/) - The main scripts handler and joining all the things together

## Authors

* **Arsalan Ul Haq Khan**

## Acknowledgments

* https://www.hashicorp.com/resources/ansible-terraform-better-together/
* https://medium.com/faun/building-repeatable-infrastructure-with-terraform-and-ansible-on-aws-3f082cd398ad