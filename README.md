# terraform-pipeline-aws

Terraform pipeline for AWS.

---

## Changelog

1. Added Ansible pipeline.
2. Added gating to pipelines.
3. Restructured codes and variables.
4. Updated [README](README.md) to reflect changes.

## Overview

Terraform pipelining experiments - provision resources in a target AWS environment.

### Current Deployments

1. [API](modules/security_demo_endpoint/) application security [implementations](modules/security_demo/)
2. Event-driven [infrastructure](modules/tennis/)

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

## Extras

1. Ansible Pipeline

    The [ansible.yml](.github/workflows/ansible.yml) pipeline runs the Ansible [playbook](ansible/playbook.yml) in the ansible directory. The credentials are specific to its current target, so you will have to update the pipeline to use your own credentials for your own targets to test it.
