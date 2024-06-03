packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
    }

source "amazon-ebs" "amazon-linux" {
  region        = "us-east-2"
  ami_name      = "ami-version-1.0.1-{{timestamp}}"
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  source_ami    = "ami-00beae93a2d981137"
  ami_regions   = ["us-east-1"]
}

build {
  name    = "hq-packer"
  sources = ["source.amazon-ebs.amazon-linux"]

  provisioner "file" {
    source      = "provisioner.sh"
    destination = "/tmp/provisioner.sh"
  }

  provisioner "shell" {
    inline = ["chmod +x /tmp/provisioner.sh"]
  }

  provisioner "shell" {
    inline = ["ls -la /tmp"]
  }

  provisioner "shell" {
    inline = ["pwd"]
  }

  provisioner "shell" {
    inline = ["cat /tmp/provisioner.sh"]
  }

  provisioner "shell" {
    inline = ["/bin/bash -x /tmp/provisioner.sh"]
  }
}
    