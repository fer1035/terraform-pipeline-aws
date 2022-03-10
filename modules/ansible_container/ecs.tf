resource "aws_iam_role" "role" {
  name                = format("%s_role", var.family_name)
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",

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

resource "aws_ecs_task_definition" "task" {
  family                   = var.family_name
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.role.arn
  network_mode             = "awsvpc"

  container_definitions    = jsonencode([
    {
      name             = var.family_name
      image            = var.image_name
      essential        = true
      workingDirectory = "/ansible"
    }
  ])
}

resource "aws_ecs_cluster" "cluster" {
  name = var.family_name
}

resource "aws_ecs_service" "service" {
  name                 = var.family_name
  cluster              = aws_ecs_cluster.cluster.id
  task_definition      = aws_ecs_task_definition.task.arn
  desired_count        = var.instance_count
  launch_type          = "FARGATE"
  platform_version     = "LATEST"
  force_new_deployment = var.force_new
#   iam_role             = aws_iam_role.foo.arn

#   load_balancer {
#     target_group_arn = aws_lb_target_group.foo.arn
#     container_name   = "mongo"
#     container_port   = 8080
#   }

  network_configuration {
      subnets          = [var.subnet_1, var.subnet_2]
      security_groups  = [var.security_group]
      assign_public_ip = var.public_ip
  }
}
