resource "aws_ecs_task_definition" "task" {
  family                   = var.family_name
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = "arn:aws:iam::${local.account_id}:role/ecsTaskExecutionRole"
#   network_mode             = "awsvpc"

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

#   network_configuration {
#       subnets = ["<public_subnet_id_1>", "<public_subnet_id_2>"]
#       security_groups = ["<security_group_id_port_80>"]
#       assign_public_ip = true
#   }
}