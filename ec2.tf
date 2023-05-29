
#Retrieve the latest amazon linux 2 AMI in the current region
data "aws_ami" "amazon-linux2" {
  owners = [ "amazon" ]
  most_recent = true
  filter {
    name = "name"
    values = [ "amzn2-ami-kernel-*" ]
  }
}


#Create Launch template 
resource "aws_launch_template" "LandmarktechEC2Template" {
    name = "labvpcec2template"
    description = "Template to launch EC2 instance and deploy the application"
    image_id = data.aws_ami.amazon-linux2.id
    instance_type = var.instancetype
    depends_on = [aws_rds_cluster.LabVPCDBCluster, aws_rds_cluster_instance.LabVPCDBInstances]
    vpc_security_group_ids = [aws_security_group.LandmarktechEC2SG.id]
    iam_instance_profile {
        arn = aws_iam_instance_profile.IAMinstanceprofile.arn
    }
    user_data = filebase64("installwebapp.sh")
}

#Create Auto scaling group
resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = [ aws_subnet.PrivateSubnet1.id, aws_subnet.PrivateSubnet2.id  ]
  desired_capacity   = 3
  max_size           = 3
  min_size           = 1
  health_check_type = "ELB"
  health_check_grace_period = 300
  target_group_arns = [aws_lb_target_group.LandmarktechALBTargetGroup.arn]
  launch_template {
    id      = aws_launch_template.LandmarktechEC2Template.id
    version = "$Latest"
  }
}

#Create Auto scaling attachment
resource "aws_autoscaling_attachment" "LabVCPALBAutoScalingAttach" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  alb_target_group_arn = aws_lb_target_group.LandmarktechALBTargetGroup.arn
}


#Create Application load balancer 
resource "aws_lb" "LandmarktechALB" {
    name = "LandmarktechALB"
    load_balancer_type = "application"
    security_groups = [aws_security_group.LandmarktechSG.id]
    internal = false
    ip_address_type = "ipv4"
    subnets = [ aws_subnet.PublicSubnet1.id, aws_subnet.PublicSubnet2.id ] 
}

#Create application load balancer listener
resource "aws_lb_listener" "front_end" {
    load_balancer_arn = aws_lb.LandmarktechALB.arn
    port =  "80"
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.LandmarktechALBTargetGroup.arn
        
    }
}

#Create application load balancer target group
resource "aws_lb_target_group" "LandmarktechALBTargetGroup" {
    name = "landmaktechalbtargetgroup"
    port = 8443
    protocol = "HTTP"
    vpc_id = aws_vpc.Landmarktechvpc.id
    target_type = "instance"
    health_check {
      matcher = "200"
      path = "/"
      interval = 10
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
    stickiness {
      type = "lb_cookie"
      cookie_duration = 120
    }
}