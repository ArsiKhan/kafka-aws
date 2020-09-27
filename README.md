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

### Variants
There are two variants for the infrastructure deployment. One is for **Existing VPC** and the other one for a **New-VPC**. Browse to the specific directory and follow further instructions.

### SSH pem file
You'll need to create a key pair in AWS. This would be used by the Cluster instances and later by Ansible script to do the config changes. Once the key pair is created download the .pem file and move it to the ansible dir for eg. in case of New-VPC it would be placed at:
```
New-VPC/ansible/<key-filename>.pem
```

## Cluster Variables

Open the external_var.yml and change the values for your environment.
```
$ nano ansible/vars/external_vars.yml
```
### Things to note
* For using Existing-VPC deployment there must be 1 VPC and id 3 subnet ids in the variables file.

* For using New-VPC 1 VPC cidr block and 3 subnet cidr blocks must be provided.

## Deployment

Browse to the ansible directory and run the ansible playbook command
```
$ cd ../ansible
$ ansible-playbook -i dyn_inven terraform.yaml
```

## Testing
After ansible playbook is done deploying and configuring the resources, open the exhibitor console for anyone of the deployed servers by browsing to the following endpoint:
```
<public-ip>:8181
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