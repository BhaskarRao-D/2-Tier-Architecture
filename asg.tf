resource "aws_launch_configuration" "launch_config" {
  name_prefix     = "aws_launch_config"
  image_id        = "ami-03c7c1f17ee073747"
  instance_type   = "t2.micro"
  key_name        = "A-M"
  security_groups = [aws_security_group.webserver-sg.id]

  lifecycle {
    create_before_destroy = true
  }

  user_data = filebase64("${path.module}/script.sh")

}

resource "aws_autoscaling_group" "asg-group" {
  name                 = "asg-group"
  desired_capacity     = 2
  max_size             = 3
  min_size             = 2
  force_delete         = true
  depends_on           = [aws_lb.application-lb]
  target_group_arns    = [aws_lb_target_group.target-group.arn]
  health_check_type    = "ELB"
  launch_configuration = aws_launch_configuration.launch_config.name
  vpc_zone_identifier  = [aws_subnet.publicsubnet1.id, aws_subnet.publicsubnet2.id]

}
