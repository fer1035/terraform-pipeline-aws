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

source "docker" "FAMILY" {
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
    "WORKDIR /var/FAMILY",
    "ENTRYPOINT ./run.sh"
  ]
}

build {
  /* name    = "python-host"  //arbitrary for logging purposes */
  sources = [
    "source.docker.FAMILY"
  ]

  provisioner "shell" {
    inline = [
      "mkdir -p /tmp/FAMILY"
    ]
  }

  provisioner "file" {
    sources     = [
      "ansible/"
    ]
    destination = "/tmp/FAMILY/"
  }

  provisioner "shell" {
    /* environment_vars = [  // not currently in-use
      "FOO=hello world",
    ] */
    inline = [
      "apt-get update",
      "apt-get install openssh-client curl python3 -y",
      "python3 -m pip install --upgrade pip",
      "python3 -m pip install ansible",
      "mv /tmp/FAMILY/ /var/",
      "chmod +x /var/FAMILY/run.sh",
      "mkdir -p ~/.ssh",
      "mv /var/FAMILY/id_rsa  ~/.ssh/",
      "mv /var/FAMILY/id_rsa.pub  ~/.ssh/",
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
        repository = "ECR_REPO/FAMILY"
        tags       = [
          "DEFAULT_TAG"
        ]
    }
    post-processor "docker-push" {
      /* login          = true  // these are for Docker and other sites, not ECR
      login_username = "USERNAME"
      login_password = "PASSWORD" */
      ecr_login      = true
      aws_access_key = "AWS_ACCESS_KEY_ID"
      aws_secret_key = "AWS_SECRET_ACCESS_KEY"
      login_server   = "https://ECR_REPO/"
    }
  }
}
