# launch template for webserver

resource "aws_launch_template" "webserver-launch-template" {
  image_id               = var.ami 
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ip.id
  }
  key_name = var.keypair

  placement {
    availability_zone = "random_shuffle.az_list.result"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "werbserver-launch-template"
    }
  }

  #   user_data = filebase64("${path.module}/wordpress.sh")
}

# ---- Autoscaling for webserver application

resource "aws_autoscaling_group" "webserver_asg" {
  name                      = "webserver-asg"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  vpc_zone_identifier = [

    aws_subnet.private[0].id,
    aws_subnet.private[1].id
  ]

  launch_template {
    id      = aws_launch_template.webserver-launch-template.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "webserver-asg"
    propagate_at_launch = true
  }
}

# attaching autoscaling group of  webserver application to internal loadbalancer

resource "aws_autoscaling_attachment" "asg_attachment_webserver" {
  autoscaling_group_name = aws_autoscaling_group.webserver_asg.name
  lb_target_group_arn   = aws_lb_target_group.webserver-tgt.arn
}