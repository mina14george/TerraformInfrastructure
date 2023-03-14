# External loadbalancer
resource "aws_lb" "external_alb" {
  name     = "externalAlb"
  internal = false
  security_groups = [aws_security_group.ext-alb-sg.id]

  subnets = [for subnet in aws_subnet.public : subnet.id ]

   tags ={
      Name = "external_alb"
    }
  

  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
}

#  create a target group for the external load balancer

resource "aws_lb_target_group" "nginx-tgt" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "nginx-tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.myvpc.id
}

# create nginxlistener for load balancer

resource "aws_lb_listener" "nginx-listner" {
  load_balancer_arn = aws_lb.external_alb.arn
  port              = 443
  protocol          = "HTTP"
#  certificate_arn   = aws_acm_certificate_validation.bulwm.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tgt.arn
  }
}

# ---Internal Load Balancers for webservers----

resource "aws_lb" "ialb" {
  name     = "ialb"
  internal = true
  security_groups = [aws_security_group.int-alb-sg.id]

  subnets = [for subnet in aws_subnet.private : subnet.id if subnet.cidr_block == "172.16.3.0/24" || subnet.cidr_block == "172.16.4.0/24"]

  tags = {
      Name = "ACS-int-alb"
    }

  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
}

# --- target group  for webserver -------

resource "aws_lb_target_group" "webserver-tgt" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "webserver-tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.myvpc.id
}


# web listener 

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.ialb.arn
  port              = 443
  protocol          = "HTTP"
#  certificate_arn   = aws_acm_certificate_validation.bulwm.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver-tgt.arn
  }
}
