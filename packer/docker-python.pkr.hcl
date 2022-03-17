packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "python" {
  image   = "python:slim-buster"
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
    "ONBUILD RUN apt-get update && apt-get upgrade -y && python3 -m pip install --upgrade pip",
    "WORKDIR /var/start",
    "VOLUME . /var/start",
    "ENTRYPOINT /var/start/run.sh"
  ]
}

build {
  name    = "python-host"
  sources = [
    "source.docker.python"
  ]

  /* post-processor "docker-import" {  // this is only for non-commits, i.e. export or discard
    repository =  "myrepo/myimage"
    tag        = "0.7"
  } */
  post-processor "docker-tag" {
      repository = "531133914787.dkr.ecr.us-east-1.amazonaws.com/packer-test"
      tags       = ["latest"]
  }
  post-processor "docker-push" {
    ecr_login      = true
    aws_access_key = "AWS_ACCESS_KEY_ID"
    aws_secret_key = "AWS_SECRET_ACCESS_KEY"
    login_server   = "https://531133914787.dkr.ecr.us-east-1.amazonaws.com/"
  }
}
