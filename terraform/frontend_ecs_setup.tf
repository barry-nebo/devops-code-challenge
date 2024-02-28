# # ECS Task Definition
# resource "aws_ecs_task_definition" "frontend_task_definition" {
#   family                   = "frontend"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = "1024"
#   memory                   = "3072"
#   execution_role_arn       = aws_iam_role.ecs_execution_role.arn


#   container_definitions = jsonencode([{
#     name  = "frontend-image"
#     image = "172316546414.dkr.ecr.us-east-1.amazonaws.com/frontend:latest"
#     cpu   = 1024

#     portMappings = [{
#       name          = "frontend-image-8080-tcp"
#       containerPort = 3000
#       hostPort      = 3000
#       protocol      = "tcp"
#       appProtocol   = "http"
#       memory        = 512
#     }]

#     essential = true

#     log_configuration = {
#       logDriver = "awslogs"
#       options   = {
#         "awslogs-create-group"         = "true"
#         "awslogs-group"                = "/ecs/frontend"
#         "awslogs-region"               = "us-east-1"
#         "awslogs-stream-prefix"        = "ecs"
#       }
#     }
#   }])
# }



# # ECS Service
# resource "aws_ecs_service" "frontend_ecs_service" {
#   name            = "frontend-ecs-service"
#   cluster         = aws_ecs_cluster.ecs_cluster_subnet1.id
#   task_definition = aws_ecs_task_definition.frontend_task_definition.arn
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets = [aws_subnet.subnet1.id]
#     security_groups = [aws_security_group.subnet_security_group.id]
#     assign_public_ip = true
#   }

#   desired_count = 1
# }