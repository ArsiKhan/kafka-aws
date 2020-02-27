# Multi-Broker HA Kafka Cluster in AWS

This Packer, Ansible, Docker and Terraform code can be used to instantiate your Kafka Cluster in AWS with its own Zookeeper cluster.

## Getting Started

These instructions will get you a copy of the infrastructure up and running on your AWS account.

### Prerequisites

At this moment these manifests can only work in AWS regions which support 3 or more availability zones. Additional pre-reqs are as below:
* AWS-Cli
* Packer
* Ansible-2.8
* Terraform v0.12.20 or above
* AWS account with an IAM user having appropriate permissions

Inst alling Ansible 2.8 on a Ubuntu 18.04 machine
```
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository ppa:ansible/ansible-2.8
sudo apt-get install ansible=2.8.8-1ppa~bionic
```

### Underlying Concept

The idea here is that we'll be first creating an AMI with [Packer](https://packer.io/) using the [Ansible provisioner](https://packer.io/docs/provisioners/ansible.html) having  Kafka and Scala bundled inside a docker container on the Machine Image.

Once the image is created we'll be calling another Ansible script which uses [Terraform](https://docs.ansible.com/ansible/latest/modules/terraform_module.html) module to provision the AWS Infrastructure. The module provisions virtual machines or cloud instances, and then we hand over the reins to Ansible again to finish up the configuration of our OS and Kafka Cluster.

### Building the Golden Image
Clone the repository on your local machine with all the pre-requisites installed.

The easiest way to use AWS credentials is creating a profile and exporting the profile name as an environment variable.

```
arsalan@LINFRA-ARSALAN:~/Office/Repos/mine/kafka-aws$ aws configure --profile kafka
AWS Access Key ID [None]: *****************
AWS Secret Access Key [None]: *******************
Default region name [None]: us-east-1
Default output format [None]:

export AWS_PROFILE=kafka
```
Browse to the directory with packer manifests
```
cd packer
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
packer build -var-file=variables.json packer.json
```
Note the AMI-ID as this would be required in the next step.
## Provisioning the Cluster

Open the external_var.yml
```
nano ../ansible/vars/external_vars.yml
```
Add the variables for provisioning the cluster
```
region: "us-west-2"
s3_bucket_name: "exhibitor-bucket-arsalan"
environment_name: "kafka-zk"
my_public_ip: "1.1.1.1/1"
ami_id: "ami-0f7d1218068eef0e2"
instance_type: "t2.medium"
key_name: "kafka-zookeeper-cluster"
volume_size: "20"
```

Browse to the ansible directory and run the ansible playbook command
```
cd ../ansible
ansible-playbook -i dyn_inven terraform.yaml
```
### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc

