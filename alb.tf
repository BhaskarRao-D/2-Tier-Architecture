#creation of target group 
resource "aws_lb_target_group" "target-group" {

  health_check {
    interval            = 12
    path                = "/"
    protocol            = "HTTP"
    timeout             = 6
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "alb-demo"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id

}

#creation of alb
resource "aws_lb" "application-lb" {
  name               = "application-lb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webserver-sg.id]
  subnets            = [aws_subnet.publicsubnet1.id, aws_subnet.publicsubnet2.id]

  tags = {
    Name = "Whiz-alb"
  }
}

#creation of lisetner
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.target-group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "ec2-attach" {
  count            = length(aws_instance.web-server)
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.web-server[count.index].id
}
