resource "aws_ecs_task_definition" "task" {
  family = var.family_name
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = 256
  memory = 512
  execution_role_arn = "arn:aws:iam::${local.account_id}:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([
    {
      name = var.family_name
      image = var.image_name
      essential = true
      workingDirectory = "/app"
    }
  ])
}

resource "aws_ecs_cluster" "cluster" {
  name = var.family_name
}

resource "aws_ecs_service" "service" {
  name = var.family_name
  cluster = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count = var.instance_count
  launch_type = "FARGATE"
  platform_version = "LATEST"
  force_new_deployment = var.force_new
  network_configuration {
      subnets = ["subnet-072107252df3c7e87", "subnet-03b71dab2f9a1bb6f"]
      security_groups = ["sg-0545e89a35792bf63"]
      assign_public_ip = true
  }
}
