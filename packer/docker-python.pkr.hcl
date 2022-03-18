packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}

variable "docker_image" {
  type    = string
  default = "python:slim-buster"
}

source "docker" "python" {
  image   = var.docker_image
  commit  = true
  changes = [
    /* "USER www-data",
    "WORKDIR /var/www",
    "ENV HOSTNAME www.example.com",
    "VOLUME /test1 /test2",
    "EXPOSE 80 443",
    "LABEL version=1.0",
    "ONBUILD RUN date",
    "CMD [\"nginx\", \"-g\", \"daemon off;\"]",
    "ENTRYPOINT /var/www/start.sh" */
    "ENTRYPOINT bash /var/ansible/run.sh"
  ]
}

build {
  /* name    = "python-host"  //arbitrary for logging purposes */
  sources = [
    "source.docker.python"
  ]

  provisioner "shell" {
    inline = [
      "mkdir -p /tmp/ansible"
    ]
  }

  provisioner "file" {
    sources     = [
      "ansible/"
    ]
    destination = "/tmp/ansible/"
  }

  provisioner "shell" {
    /* environment_vars = [
      "FOO=hello world",
    ] */
    inline = [
      "apt-get update",
      "apt-get install openssh-client curl python3 -y",
      "python3 -m pip install --upgrade pip",
      "python3 -m pip install ansible",
      "mv /tmp/ansible/ /var/",
      "mkdir -p ~/.ssh",
      "mv /var/ansible/id_rsa  ~/.ssh/",
      "mv /var/ansible/id_rsa.pub  ~/.ssh/",
      "sed -i 's/\\n/\n/g' ~/.ssh/id_rsa",
      "chmod 600 ~/.ssh/id_rsa",
      "chmod 600 ~/.ssh/id_rsa.pub"
    ]
  }

  post-processors {
    /* post-processor "docker-import" {  // this is only for non-commits, i.e. export or discard
      repository =  "myrepo/myimage"
      tag        = "0.7"
    } */
    post-processor "docker-tag" {
        repository = "531133914787.dkr.ecr.us-east-1.amazonaws.com/packer-test"
        tags       = [
          "latest"
        ]
    }
    post-processor "docker-push" {
      /* login          = true  // these are for Docker and other sites, not ECR
      login_username = "USERNAME"
      login_password = "PASSWORD" */
      ecr_login      = true
      aws_access_key = "AWS_ACCESS_KEY_ID"
      aws_secret_key = "AWS_SECRET_ACCESS_KEY"
      login_server   = "https://531133914787.dkr.ecr.us-east-1.amazonaws.com/"
    }
  }
}
