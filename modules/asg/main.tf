resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.environment}-${var.id}-instance_profile"

  role = var.iam_role
}

resource "aws_launch_template" "application_lt" {
  name_prefix   = "${var.environment}-${var.id}-launch_template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = "${var.environment}-${var.id}-instance_profile"
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = var.security_group_ids
  }

  user_data = base64encode(var.user_data)

}

resource "aws_autoscaling_group" "application_asg" {
  name                = "${var.environment}-${var.id}-asg"
  max_size            = 3
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = var.asg_subnets

  launch_template {
    id      = aws_launch_template.application_lt.id
    version = aws_launch_template.application_lt.latest_version
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns, traffic_source]
  }


}

resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name                      = "${var.environment}-${var.id}-cpu-scaling-policy"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = 30
  autoscaling_group_name    = aws_autoscaling_group.application_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50
  }
}


resource "aws_autoscaling_attachment" "application_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.application_asg.name
  alb_target_group_arn   = var.alb_target_group_arn

}