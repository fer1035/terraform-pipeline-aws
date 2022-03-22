resource "aws_iam_role" "role" {
  name                = format("%s_ECSTaskRole", var.family_name)
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
  assume_role_policy  = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": "ECSTaskExecution"
        }
    ]
}
EOF
}

resource "aws_ecs_cluster" "cluster" {
  name = var.family_name
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.family_name
  requires_compatibilities = ["${var.launch_type}"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.role.arn
  network_mode             = "awsvpc"

  container_definitions    = jsonencode([
    {
      name             = var.family_name
      image            = "${aws_ecr_repository.repository.repository_url}:${var.default_tag}"
      essential        = true
      workingDirectory = "/var/${var.family_name}"
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
