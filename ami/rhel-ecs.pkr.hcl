packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "rhel" {
  ami_name      = "rhel-ecs"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "RHEL-9.0.0_HVM*-x86_64-0-Hourly2-GP2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["309956199498"]
  }

  ssh_username = "ec2-user"
}

build {
  name = "rhel-ecs"
  sources = [
    "source.amazon-ebs.rhel"
  ]

  provisioner "shell" {
    inline = [
      "curl -O https://s3.us-east-1.amazonaws.com/amazon-ecs-agent-us-east-1/amazon-ecs-init-latest.x86_64.rpm",
      "sudo yum localinstall -y amazon-ecs-init-latest.x86_64.rpm",
    ]
  }
}