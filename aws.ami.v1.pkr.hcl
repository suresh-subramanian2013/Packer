packer {
  required_plugins {
    amazon-ebs= {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon-linux" {
  region        = "us-east-1"
  ami_name      = "ami-version-1.0.1-{{timestamp}}"
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  source_ami    = "ami-030edc11f90d05d8c"
  ami_regions   = ["us-east-1"]
}

build {
  name    = "hq-packer"
  sources = ["source.amazon-ebs.amazon-linux"]

    provisioner "ansible" {
        playbook_file = "./playbook.yaml"
        user = "ec2-user"
        use_proxy = false
    }
}
