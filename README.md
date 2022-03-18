# terraform-pipeline-aws

Terraform pipeline for AWS.

---

## Latest Changes

1. Added container module.
2. Added Packer pipeline.
2. Combined pipelines using caller workflow.
4. Updated [README](README.md) to reflect changes.

## Overview

Terraform pipelining experiments - provision resources in a target AWS environment.

### Current Deployments

1. [API](modules/security_demo_endpoint/) application security [implementations](modules/security_demo/)
2. Event-driven [infrastructure](modules/tennis/)
3. Container [cluster and task](modules/container/)

## Contribute

0. Quick way: use an IDE with Git integrations instead (such as Visual Studio Code).

1. Clone the *main* branch.

    ```bash
    git clone https://github.com/fer1035/terraform-pipeline-aws.git
    ```

2. Create your feature branch from *main*.

    ```bash
    git checkout -b my-branch
    ```

3. Make your changes.

4. Commit and push your feature branch to origin.

    ```bash
    git commit -m "Updating changes in my-branch."
    git push --set-upstream origin my-branch
    ```

5. Create a Pull Request from your feature branch to *main*.

    - Pull Requests will require all checks to pass before merging.

    - Both of the existing pipelines now require approvals to execute Pull Requests and merges to the **main** branch for the specified environment. You can target a different environment (or none at all), but you will need to specify your own variables as the existing ones are specific to the current environment.

## Pipelines

1. Terraform Pipeline

    The [terraform.yml](.github/workflows/terraform.yml) pipeline provisions AWS resources descibed in [main.tf](main.tf).

2. Ansible Pipeline

    The [ansible.yml](.github/workflows/ansible.yml) pipeline runs the Ansible [playbook](ansible/playbook.yml) in the ansible directory. The credentials are specific to its current target, so you will have to update the pipeline to use your own credentials for your own targets to test it.

3. Packer Pipeline

    The [packer.yml](.github/workflows/packer.yml) pipeline creates a container image and pushes it to ECR.

4. CI/CD Pipeline

    The [cicd.yml](.github/workflows/cicd.yml) executes all the other pipelines using the caller workflow. The order is Packer -> Terraform -> Ansible.
