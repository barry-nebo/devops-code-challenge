# ECS Clusters
resource "aws_ecs_cluster" "ecs_cluster_subnet1" {
  name = var.ecs_cluster_name_subnet1
}

# resource "aws_ecs_cluster" "ecs_cluster_subnet2" {
#   name = var.ecs_cluster_name_subnet2
# }

# IAM Role for ECS Task Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2008-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

# IAM Policy for ECS Task Execution Role
resource "aws_iam_policy" "ecs_execution_policy" {
  name        = "ecs_execution_policy"
  description = "Policy for ECS Task Execution Role"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:*",
          "cloudwatch:GenerateQuery"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the ECS Task Execution Role
resource "aws_iam_role_policy_attachment" "ecs_execution_attachment" {
  policy_arn = aws_iam_policy.ecs_execution_policy.arn
  role       = aws_iam_role.ecs_execution_role.name
}

# ECS Task Definition
resource "aws_ecs_task_definition" "backend_task_definition" {
  family                   = "backend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "3072"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn


  container_definitions = jsonencode([{
    name  = "backend-image"
    image = "250977187232.dkr.ecr.us-east-1.amazonaws.com/backend:latest"
    cpu   = 1024

    portMappings = [{
      name          = "backend-image-8080-tcp"
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
      appProtocol   = "http"
      memory        = 512
    }]

    essential = true

    log_configuration = {
      logDriver = "awslogs"
      options   = {
        "awslogs-create-group"         = "true"
        "awslogs-group"                = "/ecs/backend"
        "awslogs-region"               = "us-east-1"
        "awslogs-stream-prefix"        = "ecs"
      }
    }
  }])
}



# ECS Service
resource "aws_ecs_service" "backend_ecs_service" {
  name            = "backend-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster_subnet1.id
  task_definition = aws_ecs_task_definition.backend_task_definition.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [aws_subnet.subnet1.id]
    security_groups = [aws_security_group.subnet_security_group.id]
    assign_public_ip = true
  }

  desired_count = 1
}